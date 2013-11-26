class RelationshipsController < ApplicationController
  before_filter :is_login

  def create
    @user = User.find(params[:relationship][:publisher_id])
    @relationship = current_user.subscribe!(@user)
    track_activity @relationship
    new_subscriber_message if @user.notification.email_subscribe_to_you?
    respond_to do |format|
      format.html { redirect_to profile_path(@user.username) }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).publisher
    current_user.unsubscribe!(@user)
    respond_to do |format|
      format.html { redirect_to profile_path(@user.username) }
      format.js
    end
  end

  private 

    def new_subscriber_message
      UserMailer.subscribe(@user.email,current_user).deliver
    end
end