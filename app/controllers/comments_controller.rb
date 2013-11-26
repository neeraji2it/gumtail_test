class CommentsController < ApplicationController
	before_filter :is_login
	before_filter :load_order

	def show
		
	end

	def new
		@comment = Comment.new
	end

	def create
		@product = Product.find(@order.product_id)
		@comment = @order.comments.build(params[:comment])
		@buyer = User.find(@order.user_id)
		if @comment.save
			track_activity @comment
			if product_user?(@product)
				new_order_comment_message(@buyer,"seller")
			else
				new_order_comment_message(@product.store.user,"buyer")
			end
			redirect_to @order, notice: "Added comment."
		else
			render 'new'
		end
	end

private
	def new_order_comment_message(to,by)
      UserMailer.order_comment(to.email,@order,by).deliver 
    end

    def load_order
    	@order = Order.find(params[:order_id])
	end
end
