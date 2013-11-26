class SocialSitesController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    if current_user
      SocialConnection.create(:user_id => current_user.id,:token =>auth_hash['credentials']['token'],:auth_secret =>auth_hash['credentials']['secret'],:provider =>auth_hash["provider"],:provider_id => auth_hash["uid"]) if !SocialConnection.exists?(:provider => auth_hash["provider"],:provider_id => auth_hash["uid"])
      redirect_to "/find_friends"
    else
      if User.exists?(:provider => auth_hash["provider"],:provider_id => auth_hash["uid"])
        user = User.find_by_provider_and_provider_id(auth_hash["provider"],auth_hash["uid"])
        user.save(:token =>auth_hash['credentials']['token'],:auth_secret =>auth_hash['credentials']['secret'],:validate => false)
        user_signup(user,auth_hash,'login')
        redirect_to after_sign_in_path_for(user)
      else
        user = (auth_hash["provider"] == 'facebook' ? User.create_from_facebook(auth_hash) : User.create_from_twitter(auth_hash))
        user_signup(user,auth_hash,'login')
        redirect_to complete_social_signup_settings_path
      end
    end
  end
  
  private
  def user_signup(user,auth,status)
    sign_in(:user, user, :bypass => true)
    flash[:notice] = "You can now login using #{auth["provider"].capitalize} too!"
  end

end
