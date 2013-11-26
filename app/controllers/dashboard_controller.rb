class DashboardController < ApplicationController
  before_filter :auth
  def index
  end
  
  def products
    @products = current_user.store.present? ? Product.where(store_id: current_user.store.id)  : nil
    #@available_products = @products.present? ? @products.where("quantity != ? or unlimited = ?", 0, true) : nil 
    @sold_out_products = @products.present? ? @products.where(quantity: 0) : nil

  end
  
  def orders
    #@orders = Order.where("product_id IN (#{current_user.store != nil ? current_user.store.products.map{|p| p.id}.split(",").join(",") : '0'})")
    #                     .joins(:product).select("orders.*,products.product_title,products.product_type")
    #temporary
    @orders = Order.where(publisher_id: current_user.id).joins(:product).select("orders.*,products.product_title,products.product_type")
  end
  
  def views
    @products = current_user.store.present? ? Product.where(store_id: current_user.store.id) : nil
    @store = current_user.store 
    @referrers = @store.present? ? Traffic.current_store_traffic(@store.id) : nil
  end

  def reviews
    
  end
end
