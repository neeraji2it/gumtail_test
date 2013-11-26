# == Schema Information
#
# Table name: product_variants
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  option       :string(255)
#  price_change :decimal(, )
#  quantity     :integer
#  product_id   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ProductVariant < ActiveRecord::Base
  attr_accessible :name,:option, :price_change, :product_id, :quantity
  belongs_to :product
end
