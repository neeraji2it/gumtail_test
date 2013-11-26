class RequestsController < ApplicationController
	before_filter :correct_user, only: :index
	def index	      
	   @requests = @product.requests
	end

	def create
		@product = Product.find(params[:request][:product_id])
		user_id = current_user.blank? ? 0 : current_user.id
		email = current_user.blank? ? params[:request][:email] : current_user.email
		publisher_id = params[:request][:publisher_id]
		@publisher = User.find(publisher_id)
	    @request = @product.requests.create(publisher_id: publisher_id, product_id: @product.id, email: email, user_id: user_id, note: params[:request][:note])
	    track_activity @request if current_user
	    #new_request_message if @publisher.notification.email_request_sold_out_product?
	    respond_to do |format|
	      format.html { redirect_to product_path(:number => @product.random_no) }
	      format.js
	    end
	end

private 
    def new_request_message
      UserMailer.product_request(@publisher.email, @product.to_json).deliver
    end

    def correct_user
		@product = Product.find_by_random_no(params[:random_no])
	rescue
		redirect_to root_url
	end
end
