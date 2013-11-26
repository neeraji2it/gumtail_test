# == Schema Information
#
# Table name: product_offers
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  amount_off :decimal(, )
#  quantity   :integer
#  product_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductOffer < ActiveRecord::Base
  attr_accessible :amount_off, :code, :product_id, :quantity
  belongs_to :product
end
