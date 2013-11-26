class SocialSitesController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    puts auth_hash.inspect
    if current_user
      SocialConnection.create(:user_id => current_user.id,:token =>auth_hash['credentials']['token'],:auth_secret =>auth_hash['credentials']['secret'],:provider =>auth_hash["provider"],:provider_id => auth_hash["uid"]) if !SocialConnection.exists?(:provider => auth_hash["provider"],:provider_id => auth_hash["uid"])
      redirect_to "/find_friends"
    else
      if User.exists?(:provider => auth_hash["provider"],:provider_id => auth_hash["uid"])
        user = User.find_by_provider_and_provider_id(auth_hash["provider"],auth_hash["uid"])
        user.token = auth_hash['credentials']['token']
        user.auth_secret =auth_hash['credentials']['secret']
        user.verified = auth_hash["extra"]["raw_info"]["verified"]
        user.picture = auth_hash["info"]["image"]
        user.bio = auth_hash["info"]["description"]
        user.location = (auth_hash["provider"] == 'facebook' ? (auth_hash["extra"]["raw_info"]["location"].nil? ? nil : auth_hash["extra"]["raw_info"]["location"]["name"]) : auth_hash["extra"]["raw_info"]["location"])
        user.save(:validate => false)
        sign_in(:user, user, :bypass => true)
        flash[:notice] = "You can now login using #{auth_hash["provider"].capitalize} too!"
        redirect_to after_sign_in_path_for(user)
      else
        user = (auth_hash["provider"] == 'facebook' ? User.create_from_facebook(auth_hash) : User.create_from_twitter(auth_hash))
        sign_in(:user, user, :bypass => true)
        flash[:notice] = "You can now login using #{auth_hash["provider"]} too!"
        redirect_to complete_social_signup_settings_path
      end
    end
  end

end
