# == Schema Information
#
# Table name: user_card_details
#
#  id                       :integer          not null, primary key
#  user_id                  :integer
#  card_id                  :string(255)
#  card_type                :string(255)
#  last_4_digits            :string(255)
#  shipping_address_present :boolean          default(FALSE)
#  street_address           :string(255)
#  city                     :string(255)
#  state                    :string(255)
#  post_code                :string(255)
#  country                  :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class UserCardDetails < ActiveRecord::Base
	attr_accessible :user_id
	belongs_to :user
end
