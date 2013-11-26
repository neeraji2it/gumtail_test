# == Schema Information
#
# Table name: recommendations
#
#  id         :integer          not null, primary key
#  product_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Recommendation < ActiveRecord::Base
  attr_accessible :user_id,:product_id,:current_user_id, :product_user_id
  attr_accessor :current_user_id, :product_user_id
  belongs_to :user
  belongs_to :product
  validate :owner_validation
  validates_uniqueness_of :user_id, :scope => :product_id,  message: "already recommended this product" 
   
  ####### Users recommended products ###########
  def self.recommended_products(ids)
    joins(:user,:product).joins("left join stores on stores.id = products.store_id").joins("left join file_handlers on file_handlers.product_id = products.id").select("products.product_title as product_title,products.created_at as created_at,stores.store_name as store_name,stores.store_url as store_url,users.first_name as full_name,users.username as username,file_handlers.file_path as product_photo,file_handlers.id as file_id").where("recommendations.user_id IN (#{ids.empty? ? '0' : ids.split(",").join(",")})")
  end


private

  def owner_validation
    if self.current_user_id == self.product_user_id
      errors.add(:base, "Sorry, you can't recommend your own products")
    end
  end

end
