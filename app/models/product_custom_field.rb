# == Schema Information
#
# Table name: product_custom_fields
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  product_id :integer
#  required   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductCustomField < ActiveRecord::Base
   attr_accessible :name,:field_type, :product_id, :product_type, :required
   belongs_to :product

end
