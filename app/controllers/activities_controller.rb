class ActivitiesController < ApplicationController
  def index
  	#personalize this query for each user 
    @activities = Activity.from_users_subscribed_by(current_user).includes(:user,:trackable)
  end
end
