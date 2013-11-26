# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  order_id   :integer          not null
#  user_id    :integer          not null
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
   attr_accessible :user_id, :content
   belongs_to :order
   validates :user_id, presence: true
   validates :content, presence: true, length: { in: 1..250 }
end
