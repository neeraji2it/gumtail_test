class OrdersController < ApplicationController
	#########Show all order's for a user or bought by a user.#########
	#before_filter :is_login, except: [:new,:create]
	before_filter :correct_user, only: :update
	#before_filter :only_buyer_and_seller, only: :show
	def index

	end

	def new
		@order = Order.new
	end

	########################Show a particular order.##################
	def show
		@order = Order.find(params[:id])
		@comment = Comment.new
	end

	def update
		@order = Order.find(params[:id])
		########################For updating shipping info, courier and tracking no etc.##################
	    #if @order.update_shipping_info
	    #  redirect_to orders_url, notice: "Updated order."
	    #else
	    #  render :edit
	    #end

	end


	def create
		user_id = signed_in? ? current_user.id : 0
		@pay = Payment.new(params[:order], user_id)
		if @order = @pay.save
			track_activity @order if current_user.present?
			@publisher = User.find(@order.publisher_id)
			@publisher.update_uncleared_balance(@order.order_total)
			@order.product.update_quantity_status(@order.quantity)
			new_buyer_message if @publisher.notification.email_purchase_your_product?
			order_confirmation
			respond_to do |format|
		      format.html { redirect_to ROOT_URL + order_path(@order) }
		      format.js
		    end
		end
	end

	private
		def correct_user
			@product = current_user.products.find_by_id(params[:product_id])
			@order = @product.orders.find_by_id(params[:id])
		rescue
			redirect_to root_url
		end

		def only_buyer_and_seller
			@order = Order.find(params[:id])
			if current_user and current_user.id == @order.user_id or current_user.id == @order.publisher_id
				return true
			else
				redirect_to root_url
			end

		end

	    def new_buyer_message
	      UserMailer.purchase(@publisher,@order).deliver
	    end

	    def order_confirmation
	      UserMailer.order_confirmation(@order).deliver
	    end
end
