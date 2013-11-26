# == Schema Information
#
# Table name: stores
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  store_name           :string(255)
#  delivery_returns     :text
#  more_info            :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  currency             :string(255)
#  terms_conditions     :boolean
#  store_url            :string(255)
#  show_recommendations :boolean
#  ask_questions        :boolean
#  ask_page_title       :string(255)
#  views                :integer          default(0)
#  unique_views         :integer          default(0)
#  theme_name           :string(255)
#  payout_email         :string(255)
#  custom_theme_content :text
#  store_terms :text
#

class Store < ActiveRecord::Base
  serialize :custom_appearance, ActiveRecord::Coders::Hstore
  attr_accessible :store_name,:delivery_returns,:more_info,:terms_conditions,:store_url,:show_recommendations,
                  :ask_questions, :ask_page_title,:theme_name,:custom_theme_content,:payout_email ,:store_terms, :original_theme_id,:currency
  belongs_to :user
  validates_uniqueness_of :store_name
  validates :store_name,:presence => true
  has_many :products,:dependent => :destroy
  has_many :store_views, class_name: "Traffic" 
  validates :terms_conditions,:presence => {:message => 'Accept terms and conditions'}
  before_create :update_current_theme_id

  def update_current_theme_id
    theme_id = self.original_theme_id
    theme = Theme.find(theme_id)
    theme_array = Array(theme).first.custom_appearance
    self.title = self.store_name
    self.current_theme_id = theme_id
    self.link_color = theme_array['link_color']
    self.bg_color = theme_array['bg_color']
    self.title_color = theme_array['title_color']
  end

  def traffic_count
    t = store_views.size
    t.blank? ? 0 : t
  end

  def unique_traffic_count
    t = store_views.count(:group => "ip_address")
    t.blank? ? 0 : t.size 
  end

  def total_orders
    Order.where(publisher_id: self.user_id).size
  end

  def total_sales
    Order.get_total_sales(self.user_id)
  end

  def total_conversions
    Order.where(publisher_id: self.user_id).size
  end

  def total_sales
    Order.where(publisher_id: self.user_id).sum("order_total")
  end

  %w[title description link_color bg_color title_color google_analytics].each do |key|
    attr_accessible key
    
    define_method(key) do
      custom_appearance && custom_appearance[key]
    end
  
    define_method("#{key}=") do |value|
      self.custom_appearance = (custom_appearance || {}).merge(key => value)
    end
  end

end
