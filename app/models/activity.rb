# == Schema Information
#
# Table name: activities
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  action         :string(255)
#  trackable_id   :integer
#  trackable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Activity < ActiveRecord::Base
  default_scope order("created_at desc")
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  attr_accessible :action, :trackable


  def self.from_users_subscribed_by(user)
    publisher_ids = "SELECT publisher_id FROM relationships
                         WHERE subscriber_id = :user_id"
    where("user_id IN (#{publisher_ids}) OR user_id = :user_id",
      user_id: user.id)
  end

  def self.from_your_social_circle(user)
    #social_ids user subscriptions, facebook frineds user id and twitter_friends and followers user_id
    uids = "SELECT uid FROM friends
                         WHERE user_id = #{user.id}"
    friend_ids = "SELECT id FROM users
                         WHERE provider_id IN (#{uids})"
    publisher_ids = "SELECT publisher_id FROM relationships
                         WHERE subscriber_id = :user_id"
    where("user_id IN (#{friend_ids}) OR user_id IN (#{publisher_ids}) OR user_id = :user_id",
      user_id: user.id)
  end
end
