module FacebookCreate
  extend ActiveSupport::Concern
  def self.included(base)
    base.extend ClassMethods
  end  
  module ClassMethods
    def create_from_facebook(auth_hash)
      location_name = (auth_hash["extra"]["raw_info"]["location"].nil? ? nil : auth_hash["extra"]["raw_info"]["location"]["name"])
      user = User.new(:email => auth_hash["extra"]["raw_info"]["email"],:first_name => auth_hash["extra"]["raw_info"]["first_name"],:last_name => auth_hash["extra"]["raw_info"]["last_name"],:password => Devise.friendly_token[0,20],:username => auth_hash["extra"]["raw_info"]["username"],:gender => auth_hash["extra"]["raw_info"]["gender"],:provider => auth_hash["provider"],:provider_id => auth_hash["uid"],:token => auth_hash["credentials"]["token"],:verified => auth_hash["extra"]["raw_info"]["verified"],:location => location_name,:picture => auth_hash["info"]["image"],:bio => auth_hash["info"]["description"],:auth_secret =>auth_hash['credentials']['secret'],:confirmed_at => Time.now)
      user.save(:validate => false)
      friend = Friend.find_by_uid_and_provider(auth_hash["uid"],auth_hash["provider"]) 
      if friend
        UserMailer.send_connection_notifications(friend.to_json,auth_hash["extra"]["raw_info"]["first_name"]).deliver
      end
      return user
    end
  end
end
