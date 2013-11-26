# == Schema Information
#
# Table name: shipping_profiles
#
#  id         :integer          not null, primary key
#  option     :string(255)
#  cost       :decimal(, )
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  time       :integer          default(0)
#

class ShippingProfile < ActiveRecord::Base
  attr_accessible :cost, :option, :product_id, :time
  belongs_to :product

  def shipping_info
  	self.option + "  Price:" + self.cost.to_s + "  Takes:" + self.time.to_s + "Days"
  end
end
