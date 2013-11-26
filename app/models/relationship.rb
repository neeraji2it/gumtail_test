# == Schema Information
#
# Table name: relationships
#
#  id            :integer          not null, primary key
#  subscriber_id :integer
#  publisher_id  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Relationship < ActiveRecord::Base
  attr_accessible :publisher_id, :subscriber_id
  belongs_to :subscriber, class_name: "User"
  belongs_to :publisher, class_name: "User"
  validates :subscriber_id, presence: true
  validates :publisher_id, presence: true

end
