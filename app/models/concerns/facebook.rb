module FacebookCreate
  extend ActiveSupport::Concern
  def self.included(base)
    base.extend ClassMethods
  end  
  module ClassMethods
    def create_from_facebook(auth_hash)
      email = auth_hash["extra"]["raw_info"]["email"]
      first_name = auth_hash["extra"]["raw_info"]["first_name"].present? ? auth_hash["extra"]["raw_info"]["first_name"] : nil
      last_name = auth_hash["extra"]["raw_info"]["last_name"].present? ? auth_hash["extra"]["raw_info"]["last_name"] : nil
      username = auth_hash["extra"]["raw_info"]["username"].present? ? auth_hash["extra"]["raw_info"]["username"] : nil
      gender = auth_hash["extra"]["raw_info"]["gender"].present? ? auth_hash["extra"]["raw_info"]["gender"] : nil
      location_name = (auth_hash["extra"]["raw_info"]["location"].nil? ? nil : auth_hash["extra"]["raw_info"]["location"]["name"])
      user = User.new(:email => email,
        :first_name => first_name,
        :last_name => last_name,
        :password => Devise.friendly_token[0,20],
        :username => username,
        :gender => gender,
        :provider => auth_hash["provider"],
        :provider_id => auth_hash["uid"],
        :token => auth_hash["credentials"]["token"],
        :verified => auth_hash["extra"]["raw_info"]["verified"],
        :location => location_name,
        :picture => auth_hash["info"]["image"],
        :bio => auth_hash["info"]["description"],
        :auth_secret =>auth_hash['credentials']['secret'])
      user.confirmed_at = Time.now
      user.save(:validate => false)
      friend = Friend.find_by_uid_and_provider(auth_hash["uid"],auth_hash["provider"]) 
      if friend
        UserMailer.send_connection_notifications(friend.to_json,first_name).deliver
      end
      return user
    end
  end
end
