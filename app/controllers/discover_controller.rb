class DiscoverController < ApplicationController
	before_filter :set_trends, except: :tags
	respond_to :html,:js, :except => :tags
	helper_method :cat_type

	def discover
		@categories = (cat_type == "all") ? ProductCategory.all : ProductCategory.where(category_type: cat_type)
		#Top product method needs to be used here also.
		@products = (cat_type == "all") ? Product.all : Product.where(product_type: cat_type)
	end

	def shop
		@shops = Store.includes(:products)
	end

	def people
		@users = User.all_cached
	end
	
	def tags
		@tags = Tag.limit(6)
		respond_to do |format|
	      format.html
	      format.json { render :json => @tags }
	    end
	end
private
    def set_trends
   	  #call my trend algo from here
      @tags = Tag.limit(18)
    end

    def cat_type
	    %w[all physical digital].include?(params[:sort]) ? params[:sort] : "all"
  	end

  	def catergory
  	end
end
