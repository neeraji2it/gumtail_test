class HomeController < ApplicationController
  before_filter :set_trends
  respond_to :html,:json

  #home page /
  def index
    if signed_in?
      #######Important######
      #@who_to_subscribe_to = current_user.who_to_subscibe_to.limit(5)
      ###################
      if Product.first != nil
        #@top_ids,@p_ids = Product.top_products(20,'')
        #@products = Product.featured_products.where("products.id IN (#{@p_ids.empty? ? '0' : @p_ids.split(",").join(",")})").joins("JOIN (VALUES #{@top_ids.join(",")}) as x (id, ordering) ON products.id = x.id").order('x.ordering').group("x.ordering")
        @products = Product.all

      else
        @products = []
      end
      respond_with @products do |format|
        format.json
        format.html
      end
    else
      render 'signed_out_index'
    end
  end
  
  #only products from people you've subscribe to /home/subscriptions
  def subscriptions
    ids = []
    subscribers = current_user.subscriptions 
    subscribers.each do |sub|
      user = User.find(sub.id)
      ids<< (user.store != nil ? user.store.id : '0')
    end
    @products = Product.featured_products.where("store_id IN (#{ids.empty? ? '0' : ids.split(",").join(",")})")
    respond_with @products do |format|
      format.json
      format.html { render action:'index'}
    end
    #render :action => :index
  end
  
  
  #Currently featured products from sellers on the site /home/featured
  def stories
    @stories = Activity.from_your_social_circle(current_user).includes(:user,:trackable)
    puts @stories.count
    respond_with @stories do |format|
      format.json
      format.html { render action:'index'}
    end
  end
  
  # Only products recommendaations from people in your circle /home/recommendations
  #Recommend feature will not be in the site's alpha version..
  def recommendations
    @uids = []
    @ids = []
    current_user.friends.each do |friend|
      @uids<< ("'#{friend.uid}'")
    end
    current_user.relationships.each do |sub|
      @ids<< (sub.publisher_id)
    end
    @users = User.where("provider_id IN (#{@uids.empty? ? "'0'" : @uids.split(",").join(",")})")
    @users.each do |user|
      @ids<< (user.id)
    end
    @recommendations = Recommendation.recommended_products(@ids)
    respond_with @recommendations do |format|
      format.json
      format.html { render action:'index'}
    end
  end
  
private 
  def set_trends
    #call my trend algo from here
    @tags = Tag.limit(6)
    @trends = Trend.get(6) # Just here for testing purposes
  end
end
