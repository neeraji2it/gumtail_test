require "concerns/facebook"
require "concerns/twitter"
# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string(255)      default(""), not null
#  encrypted_password      :string(255)      default(""), not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0)
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  confirmation_token      :string(255)
#  confirmed_at            :datetime
#  confirmation_sent_at    :datetime
#  unconfirmed_email       :string(255)
#  provider                :string(255)
#  provider_id             :string(255)
#  token                   :string(255)
#  first_name              :string(255)
#  last_name               :string(255)
#  username                :string(255)
#  bio                     :text
#  location                :string(255)
#  website                 :string(255)
#  gender                  :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  balance                 :string(255)      default("0")
#  auth_secret             :string(255)
#  timezone                :string(255)
#  verified                :boolean
#  picture                 :string(255)
#  account_activation_code :string(255)
#  avatar_id               :integer          default(0)
#  referer                 :string(255)
#  country                 :string(255)
#  localization            :string(255)
#  card_details_id         :integer          default(0)
#  user_address_id         :integer          default(0)
#

class User < ActiveRecord::Base
  include FacebookCreate
  include TwitterCreate
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:async,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:confirmed_at,:confirmation_sent_at,:confirmation_token,
    :username,:first_name,:last_name,:bio,:location,:picture,:gender,:provider,:provider_id,:token,:status,:current_password,
    :website,:auth_secret,:timezone,:verified,:account_activation_code,:country,:localization
  attr_accessor :status,:current_password,:time_zone
  validates :username,:first_name,:last_name,:presence => true
  validates :gender,:presence => true,:if => Proc.new{|f| f.status == 'update' }
  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name), allow_blank: true
  has_one :notification,:dependent => :destroy
  has_one :store,:dependent => :destroy
  has_one :card, class_name:  "UserCardDetails", dependent: :destroy
  has_one :address, class_name:  "UserAddress", dependent: :destroy
  has_many :activities
  has_many :orders
  has_many :social_connections,:dependent => :destroy
  has_many :files, class_name: "FileHandler",:dependent => :destroy
  has_many :FileHandlers, dependent: :destroy
  has_many :friends, dependent: :destroy
  has_many :relationships, foreign_key: "subscriber_id", dependent: :destroy
  has_many :subscriptions, through: :relationships, source: :publisher
  has_many :reverse_relationships, foreign_key: "publisher_id", class_name:  "Relationship", dependent:   :destroy
  has_many :subscribers, through: :reverse_relationships
  has_many :questions
  has_many :themes

  has_many :recommendations,:dependent => :destroy
  validates :username,:uniqueness => true,:on => :create
  before_create { generate_ref_id(:ref_id) }
  after_create :create_notification_settings
  after_create :update_user_drawer
  after_save    :expire_contact_all_cache
  after_destroy :expire_contact_all_cache
  #after_save :fix_updated_counters
    
  def self.all_cached
    Rails.cache.fetch('User.all') { all }
  end


  def full_name
    self.first_name.nil? ? (''+(self.last_name.nil? ? '' : self.last_name)) : (self.first_name+' '+(self.last_name.nil? ? '' : self.last_name))
  end

  def avatar(version)
    photo = FileHandler.where("id = ? and is_cover = ?", self.avatar_id, false).first
    return photo.blank? ? "http://cf1.thefancy.com/UserImages/original/jack.jpg" : photo.file_path_url(:"#{version}").to_s
      
  end

  def save_with(referer)
    self.referer = referer unless referer == "null"
    self.save   
  end

  def subscribed?(publisher)
    relationships.find_by_publisher_id(publisher.id)
  end

  def subscribe!(publisher)
    relationships.create!(publisher_id: publisher.id)
  end

  def unsubscribe!(publisher)
    relationships.find_by_publisher_id(publisher.id).destroy
  end
  

  def create_notification_settings
    @notification = self.build_notification
    @notification.save!
  end

  def update_user_drawer
    Order.update_all "user_id = #{self.id}", ['email = ?', self.email]
  end

  def generate_ref_id(col)
    begin
      arr = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      self[col] = (3...7).map{ arr[rand(arr.length)] }.join
    end while User.exists?(col => self[col])
  end

  def notifications(user)
    notifications = []
    recommend(user)
    subscribe(user)
    order_transactions(user)
    return notifications
  end
  
  def recommend(user)
    recommendations = Recommendation.where("product_id IN (#{(user.store != nil and !user.store.products.empty?) ? user.store.products.map{|p| p.id}.split(",").join(",") : '0'})")
    for recommendation in recommendations
      message = recommendation.user.full_name+" recommended your product "+recommendation.product.product_title+" on "+recommendation.created_at.strftime("%b %d %Y")
      notifications << [recommendation.user_id,recommendation.product_id,message]
    end
  end
  
  def subscribe(user)
    subscribers = Relationship.where("publisher_id = #{user.id}")
    for subscriber in subscribers
      message = User.find(subscriber.subscriber_id).full_name+" subscribed  to you on "+subscriber.created_at.strftime("%b %d %Y")
      notifications << [subscriber.subscriber_id,nil,message]
    end
  end
  
  def order_transactions(user)
    orders = Transaction.where("product_id IN (#{(user.store != nil and !user.store.products.empty?) ? user.store.products.map{|p| p.id}.split(",").join(",") : '0'})")
    for order in orders
      message = order.user.full_name+" ordered your product "+order.product.product_title+" on "+order.created_at.strftime("%b %d %Y")
      notifications << [order.user_id,order.product_id,message]
    end
  end

  def update_uncleared_balance(amount)
    add_to_unclered_balance(amount)
  end

  def update_user_card_details_id(id)
    self.card_details_id = id
    save!
  end

  def update_user_address_details(id)
    self.user_address_id = id
    save!
  end
  
  def expire_contact_all_cache
    Rails.cache.delete('User.all')
  end

  def total_orders
    orders.size
  end

  def completed_orders
    orders.completed_orders.size
  end

  def dispatched_orders
    orders.dispatched_orders.size
  end

  def cancled_orders
    orders.canceled_orders.size
  end
  
  protected
  def confirmation_required?
    false
  end

  def add_to_unclered_balance(amount)
    self.uncleared_balance = self.uncleared_balance + amount.to_f
  end

end
