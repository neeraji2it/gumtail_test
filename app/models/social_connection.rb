# == Schema Information
#
# Table name: social_connections
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  provider    :string(255)
#  token       :string(255)
#  provider_id :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  auth_secret :string(255)
#

class SocialConnection < ActiveRecord::Base
   attr_accessible :provider,:provider_id,:token,:user_id,:auth_secret
   belongs_to :user
end
