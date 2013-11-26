# == Schema Information
#
# Table name: product_categories
#
#  id            :integer          not null, primary key
#  category      :string(255)
#  category_type :string(255)
#  amount        :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ProductCategory < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :products, foreign_key: "category_id"
end
