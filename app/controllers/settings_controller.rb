require "twitter"
class SettingsController < ApplicationController
  before_filter :is_login
  def account
    @user = current_user
  end
  
  #update user record /accounts/:id
  def update_account
    @user = current_user
    @user.errors.add(:current_password,'is required') if (!params[:user][:password].to_s.blank? and  params[:user][:current_password].to_s.blank?)
    if params[:user][:password].to_s.blank?
      if @user.update_without_password(params[:user])
        flash[:notice] = 'Updated successfully.'
        redirect_to account_settings_path
      else
        flash[:error] = 'Updation failed'
        render :action => 'account'
      end
    else
      if @user.errors.empty? and @user.update_with_password(params[:user])
        sign_in(@user, :bypass => true)
        flash[:notice] = 'Updated successfully.'
        redirect_to account_settings_path
      else
        flash[:error] = 'Updation failed'
        render :action => 'account'
      end
    end
  end
  
  #complete social signup /accounts/complete_social_signup
  def complete_social_signup
    #    render :layout => false
  end
  
  #updating username and password after sign up with social accounts
  def update_social_signup
    @user = current_user
    if current_user.provider != 'twitter'
      if !params[:user][:password].to_s.blank?
        @user.update_attributes(params[:user])
      else
        @user.username = params[:user][:username]
        @user.save
      end
    else
      @user.attributes = params[:user]
      @user.save(:validate => false)
    end
    sign_in(:user, @user, :bypass => true)
    redirect_to account_settings_path
  end
  
  #connecting to social site accounts/social_connect
  def social
    if current_user.provider != nil
      if current_user.provider == 'facebook'
        @f_connected = 'facebook'
        if current_user.social_connections.exists?
          @t_connected = 'twitter'
        else
          @t_connected = nil
        end
      else
        @t_connected = 'twitter'
        if current_user.social_connections.exists?
          @f_connected = 'facebook'
        else
          @f_connected = nil
        end
      end
    elsif current_user.social_connections.exists?
      @f_connected = current_user.social_connections.where("provider = 'facebook'").exists? ? 'facebook' : nil
      @t_connected = current_user.social_connections.where("provider = 'twitter'").exists? ? 'twitter' : nil
    else
      @f_connected = nil
      @t_connected = nil
    end
  end
  
  def find_friends
    social
    fetch_fb_friends
    if params[:fb_id]
      Friend.create(:user_id => current_user.id,:uid => params[:fb_id],:provider => 'facebook') if !Friend.exists?(:user_id => current_user.id,:uid => params[:fb_id])
    end
    twitter
  end
  
  def twitter
    @twi_friends = []
    if (current_user.provider != nil and current_user.provider == 'twitter') or current_user.social_connections.where("provider = 'twitter'").exists?
      fetch_tw_friends
    end
    #    Twitter.direct_message_create('kapil517', 'good1')
  end
  
  def send_twitter_message
    fetch_tw_friends
    Twitter.direct_message_create("#{params[:username]}", "#{params[:text]}")
    Friend.create(:user_id => current_user.id,:uid => params[:twitter_id],:provider => 'twitter') if !Friend.exists?(:user_id => current_user.id,:uid => params[:twitter_id])
    flash[:notice] = 'Message sent'
    redirect_to '/find_friends'
  end
  
  def user_notifications
    @notifications = current_user.notifications(current_user)
  end
  
  #notifications page /accounts/:id/notifications
  def notifications
    @user = current_user
    @notification = Notification.new
  end

  #create notifications /accounts/:id/create_notifications
  def create_notification
    @notification = current_user.build_notification(params[:notification])
    @notification.save
    redirect_to edit_notifications_setting_path(@notification)
  end

  #edit notification /accounts/:id/edit_notifications
  def edit_notifications
    @user = current_user
    @notification = Notification.find(params[:id])
  end

  #update notification /accounts/:id/notification_updation
  def notification_updation
    @user = current_user
    @notification = Notification.find(params[:id])
    @notification.update_attributes(params[:notification])
    redirect_to edit_notifications_setting_path(@notification)
  end
  private
  def fetch_fb_friends
    @fb_friends = []
    if current_user.provider != nil and current_user.provider == 'facebook'
      @fb_friends = FbGraph::User.new('me', :access_token => current_user.token).fetch.friends
    elsif current_user.social_connections.where("provider = 'facebook'").exists?
      @fb_friends = FbGraph::User.new('me', :access_token => current_user.social_connections.where("provider = 'facebook'").first.token).fetch.friends
    end
  end
  
  def fetch_tw_friends
    PostToTwitter.twitter_configuration(current_user)
    client = Twitter::Client.new
    @twi_friends = client.friends.all
  end
end
