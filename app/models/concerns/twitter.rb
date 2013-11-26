module TwitterCreate
  extend ActiveSupport::Concern
  def self.included(base)
    base.extend ClassMethods
  end  
  module ClassMethods
    def create_from_twitter(auth_hash)
      first_name = auth_hash["extra"]["raw_info"]["name"].present? ? auth_hash["extra"]["raw_info"]["name"] : nil
      username = auth_hash["extra"]["raw_info"]["screen_name"].present? ? auth_hash["extra"]["raw_info"]["screen_name"] : nil
      user = User.new(:email => auth_hash["extra"]["raw_info"]["screen_name"],:first_name => first_name,:password => Devise.friendly_token[0,20],:username => username,:provider => auth_hash["provider"],:provider_id => auth_hash["uid"],:token => auth_hash["credentials"]["token"],:verified => auth_hash["extra"]["raw_info"]["verified"],:location => auth_hash["extra"]["raw_info"]["location"],:picture => auth_hash["info"]["image"],:bio => auth_hash["info"]["description"],:auth_secret =>auth_hash['credentials']['secret'],:confirmed_at => Time.now)
      user.save(:validate => false)
      friend = Friend.find_by_uid_and_provider(auth_hash["uid"],auth_hash["provider"]) 
      if friend
        UserMailer.send_connection_notifications(friend.to_json,first_name).deliver
      end
      return user
    end
  end
end
