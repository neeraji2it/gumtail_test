class UserAddress < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user_id
  belongs_to :user
end
