require "twitter"
class PostToTwitter
  
  class<<self
    def post_to_twitter(user,message)
      twitter_configuration(user)
      client = Twitter::Client.new
      begin
        client.update(message)
        return true
      rescue Exception => e
        p "Unable to send to twitter: #{e.to_s}"
        return false
      end
    end
    def twitter_configuration(user)
      if user.provider != nil and user.provider == 'twitter'
        Twitter.configure do |config|
          config.consumer_key = (Rails.env=="development" ? TW_APP_ID : TW_APP_ID_P)
          config.consumer_secret =  (Rails.env=="development" ? TW_SEC_ID : TW_SEC_ID_P)
          config.oauth_token = user.token
          config.oauth_token_secret = user.auth_secret
        end
      else
        Twitter.configure do |config|
          config.consumer_key = (Rails.env=="development" ? TW_APP_ID : TW_APP_ID_P)
          config.consumer_secret =  (Rails.env=="development" ? TW_SEC_ID : TW_SEC_ID_P)
          config.oauth_token = user.social_connections.where("provider = 'twitter'").first.token
          config.oauth_token_secret = user.social_connections.where("provider = 'twitter'").first.auth_secret
        end
      end
    end
  end
end