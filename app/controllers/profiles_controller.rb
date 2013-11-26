class ProfilesController < ApplicationController
  before_filter :is_login,:except => [:show,:drawer, :recommends, :subscriptions, :subscribers]
  helper_method :sort_column, :sort_direction

  def subscriptions
    @user = User.find(params[:id])
    @users = @user.subscriptions.includes(:store)
    render 'show_subscribe'
  end

  def subscribers
    @user = User.find(params[:id])
    @users = @user.subscribers.includes(:store)
    render 'show_subscribe'
  end

  #current_user selled products /profiles
  def index
    @users = User.all_cached
  end

  #current_user bought products /profiles/drawer
  def drawer
    @user = User.find_by_username(params[:username])
    @products =  Order.where("user_id = ?", @user.id).includes(:product)
    @question = Question.new
    #@activities = Activity.where(user_id: @user.id).includes(:user,:trackable)
  end

  #current_user recommended products /profiles/recommendations
  def recommends
    @user = User.find_by_username(params[:username])
    @products = @user.recommendations
    @question = Question.new
    #@activities = Activity.where(user_id: @user.id).includes(:user,:trackable)
  end

  def activities
    @user = User.find_by_username(params[:username])
    @question = Question.new
    @activities = Activity.where(user_id: @user.id).includes(:user,:trackable)
  end

  #user show page /profiles/:id
  def show
    @user = User.find_by_username(params[:username])
    @products = @user.store != nil ? @user.store.products.limit(10) : []
    @question = Question.new
    #@activities = Activity.where(user_id: @user.id).includes(:user,:trackable)
  end
  
  #user balance details /profiles/balance
  def balance
    @orders = Order.where(publisher_id: current_user.id).order(sort_column + " " + sort_direction)
    respond_to do |format|
        format.html { render action:'wallet' }
        format.js
    end
  end
  
  #user bought product orders /profiles/shopping
  def shopping
    @orders = Order.where(user_id: current_user.id).order(sort_column + " " + sort_direction)
    respond_to do |format|
        format.html { render action:'wallet' }
        format.js
    end
  end

  def referral
    @referrals = []
    respond_to do |format|
        format.html { render action:'wallet' }
        format.js
    end
  end

  def wallet
  end

private
  
  def sort_column
    #later add sort by completed dispatched etc
    %w[date].include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
