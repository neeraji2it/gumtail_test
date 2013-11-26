# == Schema Information
#
# Table name: products
#
#  id               :integer          not null, primary key
#  store_id         :integer          not null
#  category_id      :integer          not null
#  product_title    :string(255)      not null
#  product_type     :string(255)      not null
#  description      :text             not null
#  quantity         :integer
#  unlimited        :boolean          default(FALSE)
#  views            :integer
#  sales            :string(255)
#  pricing          :string(255)
#  amount           :decimal(, )      default(0.0)
#  amount_from      :decimal(, )      default(0.0)
#  auction_id       :integer          default(0)
#  random_no        :string(255)
#  buyer_will_get   :string(255)
#  custom_message   :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commision        :integer          default(10)
#  sold             :integer          default(0)
#  initial_quantity :integer
#  unique_views     :integer          default(0)
#

class Product < ActiveRecord::Base
  attr_accessible :store_id, :category_id, :product_title, :product_type, :description, :quantity, :unlimited, :views, :sales,
    :pricing, :amount, :amount_from, :auction_id, :random_no, :buyer_will_get, :custom_message, :fields_attributes, 
    :offers_attributes, :variants_attributes, :sprofiles_attributes, :names_attributes, :tag_list, :commision
  liquid_methods :id,:product_title,:random_no, :description
  # Validations
  validates :product_title, :description, :category_id, :presence => true
  has_many :taggings
  has_many :tags, through: :taggings


  #Call Backs
  before_create :generate_random_no
  before_create :update_iq_field
  #after_save :fix_updated_counters

  ############################Additional product info################################
  belongs_to :store
  belongs_to :ProductCategory 
  has_many :orders
  has_many :recommendations,:dependent => :destroy
  has_many :fields, class_name: "ProductCustomField" 
  has_many :offers, class_name: "ProductOffer" 
  has_many :variants, class_name: "ProductVariant" 
  has_many :sprofiles, class_name: "ShippingProfile", dependent: :destroy 
  has_many :names
  has_many :product_views, class_name: "Traffic" 
  has_many :requests, dependent: :destroy
  accepts_nested_attributes_for :sprofiles, allow_destroy: true 
  accepts_nested_attributes_for :variants, allow_destroy: true 
  accepts_nested_attributes_for :offers, allow_destroy: true 
  accepts_nested_attributes_for :fields, allow_destroy: true 
  accepts_nested_attributes_for :names, allow_destroy: true 

  def requested?(email)
    requests.find_by_email(email)
  end
  def request!(publisher_id, product_id, email, user_id)
    requests.create!(publisher_id: publisher_id, product_id: product_id, email: email, user_id: user_id)
  end

  def request_count
    r = requests.count
    r.blank? ? 0 : r
  end

  
  #####################Methods needed during self.update#############################
    
  def generate_random_no
    begin
      o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
      self.random_no = (0...5).map{ o[rand(o.length)] }.join
    end while Product.exists?(:random_no => self[:random_no])
  end

  def update_iq_field
    self.initial_quantity = self.quantity
  end

  def update_quantity_status(quantity)
    self.sold = self.sold + quantity
    unless self.unlimited == true
      self.quantity  = self.quantity - quantity
    end
    save!
  end


  ############################Additional product info################################

  def cover(version)
    cover = FileHandler.where("product_id = ? and is_cover = ?", self.id, true).first
    return cover.blank? ? "http://cf2.thefancy.com/default/442515817800664429_55f4b11ef494.jpg" : cover.file_path_url(:"#{version}").to_s
  end

  def photos
    FileHandler.where("product_id = ? and is_cover = ?", self.id, false)
  end

  def product_commision
    earn = self.commision.blank? ? "" : "Earn #{ self.commision_amount(self.amount,self.commision) } per sale"
    self.amount.blank? ? "Earn #{self.commision}% per sale" : earn 
  end

  def commision_amount(price_bought,commision)
    (commision * price_bought) / 100
  end

  ############################State of product###################################
  def sold_out
    return true if self.unlimited != true && self.quantity == 0 || self.initial_quantity == self.sold
  end 

  def traffic_count
    t = product_views.size
    t.blank? ? 0 : t
  end

  def unique_traffic_count
    t = product_views.count(:group => "ip_address")
    t.blank? ? 0 : t.size
  end

  def has_been_bought(product_id,user_id)
    orders.where("product_id = ? and user_id  = ?", product_id, user_id)
  end


  ###################Algorithm for trending products##############################
  # It should take @products output_amount time_period
  ################################################################################

  
  def self.top_products(limit,category)
    top = []
    @category = ProductCategory.find_by_category(category)
    Product.include(:store).where("#{@category ? "category_id = #{@category.id}" : ''}").limit(limit).each do |product|
      #Product.all.each do |product|
      sales = product.orders.count
      views = (product.views == nil ? 0 : product.views.to_i)
      conve_rate = ((sales == 0 and views == 0) ? 0 : (sales/views.to_f)*100)
      recommends = product.recommendations.count
      total = sales.to_f+conve_rate.to_f+views.to_f+recommends.to_f
      $redis.zadd("highscores", total, product.id)
      top<<product.id
    end
    
    i = 0
    return [$redis.zrevrange("highscores", 0, limit-1).map{|id| ('('+id.to_s+','+(i=i+1).to_s+')')},top]
  end

  ############################Tags for products###################################
  def self.tagged_with(name)
    Tag.find_by_name!(name).products
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end
  
  def tag_list
    tags.map(&:name).join("# ")
  end
  
  def tag_list=(names)
    tag_lists = names.scan( /#(\w+)/ ).flatten.map( &:downcase )
    self.tags = tag_lists.map do |n|
      Tag.where(name: n.strip).first_or_create! do |tag|
        Trend.onVote(tag)
      end
    end
  end
  ################################################################################
  
  ################# featured and subscriptions ##############################
  def self.featured_products
    joins("left join stores on stores.id = products.store_id").joins("left join file_handlers on file_handlers.product_id = products.id").joins("left join taggings on taggings.product_id = products.id").joins("left join users on users.id = stores.user_id").select("product_title,products.created_at,stores.store_name as store_name,stores.store_url as store_url,users.username as username,users.first_name as full_name,file_handlers.file_path as product_photo,file_handlers.id as file_id,taggings.tag_id as tag").group("products.id,stores.store_name,stores.store_url,users.username,users.first_name,file_handlers.file_path,file_handlers.id,taggings.tag_id")
  end
  ###########################################################################

end
