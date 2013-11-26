# == Schema Information
#
# Table name: friends
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Friend < ActiveRecord::Base
  attr_accessible :provider,:uid,:user_id
  belongs_to :user
end
