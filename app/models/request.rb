# == Schema Information
#
# Table name: requests
#
#  id           :integer          not null, primary key
#  user_id      :integer          default(0)
#  publisher_id :integer          not null
#  email        :string(255)      not null
#  product_id   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Request < ActiveRecord::Base
   attr_accessible :user_id, :publisher_id, :email,:product_id,:note
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   belongs_to :product
   #after_save :fix_updated_counters
   validates :email, presence: true, uniqueness: { case_sensitive: false },
                                     format: { with: VALID_EMAIL_REGEX,  message: 'must be valid'}
   validates :note, length: { maximum: 140 }
end
