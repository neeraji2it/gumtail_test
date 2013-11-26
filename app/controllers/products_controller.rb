require 'open-uri'
class ProductsController < ApplicationController
  before_filter :is_login,:except => [:show,:top_products]
  #need a bfore filter only product user for edit and listing_complete
  before_filter :not_accessed,:only => [:new,:create]
  before_filter :create_store,:only => [:new,:create]
  before_filter(:only => [:show]) { load_store "product" }


  #display products by filter /products
  def index
    if params[:tag]
      @products = Product.tagged_with(params[:tag])
    end
  end

  def add
  end

  #new product /products/new
  def new
    @product = Product.new(params[:product])
    @categories = ProductCategory.where("category_type = ?", params[:type])
  end


  #enter new record to db for product /products
  def create
    @product = Product.new(params[:product])
    @product.store_id = current_user.store.id
    if @product.save
      FileHandler.where(:id => params[:file_ids]).update_all(product_id: @product.id) #Update product files with product id
      track_activity @product
      flash[:notice] = 'Product created successfully.'
      redirect_to listing_path(id: @product.id)
    else
      flash[:error] = 'Product creation failed.'
      redirect_to :action => 'new',:type => params[:product][:product_type]
    end
  end

  #show page /products/:number
  def show
    ########################Inform user that has previously bought this product################
    @bought = @product.has_been_bought(@product.id, current_user.id) if current_user
    ###########################################################################################
    @files = FileHandler.where("product_id =?", @product.id)
    #@recommend = current_user ? Recommendation.find_by_user_id_and_product_id(current_user.id,@product.id) : ''
    @order = Order.new
    session['r_id'] = params[:r] || 'null'
    render :layout => "custom"
  end

  #edit page /products/:number/edit
  def edit
    @status = params[:status]
    @product = Product.find_by_random_no params[:number]
    @categories = ProductCategory.where("category_type = ?", @product.product_type)
    @cover = FileHandler.where("product_id = ? and is_cover = ?", @product.id, true)
    @photos = FileHandler.where("product_id = ? and is_cover = ?", @product.id, false)
  end

  #update existing record /products/:number
  def update
    @product = Product.find_by_random_no params[:number]
    if @product.update_attributes(params[:product])
      flash[:notice] = 'Product updated successfully.'
      redirect_to "/dashboard/products"
    else
      flash[:error] = 'Product updation failed.'
      render :action => 'edit'
    end
  end

  #recommend a product /products/:id/recommend
  def recommend
    @product = Product.find(params[:id])
    # "You already recommended this product."
    @recommendation = Recommendation.create(user_id: current_user.id, product_id: @product.id, current_user_id: current_user.id,product_user_id: @product.store.user_id)
    track_activity @recommendation
    respond_to do |format|
      format.js 
    end

  end

  #/listing/:id
  def listing_complete
    @product = Product.find(params[:id])
    @files = FileHandler.where("product_id =?", @product.id)
  end

  #download digital product who bought /product/:product_no/download_product
  def download_product
    @product = Product.find_by_random_no(params[:random_no])
    if @product.product_type == 'digital' and !@product.documents.blank?
      @product.documents.each do |d|
        document = d.document_url.split('/').last
        open(document, 'wb') do |file|
          file << open(root_url+d.document.to_s).read
          send_file file, :type=>"application/zip"
        end
      end
    end
    redirect_to root_path
  end

  def not_your_product
    @product = Product.find(params[:id])
    if current_user and current_user.store != nil and @product.store_id == current_user.store.id
      redirect_to product_path(:number =>@product.random_no)
    end
  end
  
  def top_products
    if Product.first != nil
      @top_ids = Product.top_products(20,nil)
      @products = Product.joins("JOIN (VALUES #{@top_ids.join(",")}) as x (id, ordering) ON products.id = x.id").order('x.ordering')
    else
      @products = []
    end
  end
  
  def not_accessed
    if current_user.account_activation_code != nil
      flash[:error] = 'First confirm your account to sell products'
      redirect_to root_path
    end
  end
  
  def create_store
    if current_user.store == nil
      redirect_to new_store_path
    end
  end
  
  def product_delete
    @product = Product.find params[:product_id]
    @user = current_user
    @user.errors.add(:current_password,'Entered password is wrong.Please try again!') if params[:user][:current_password].to_s.blank?
    respond_to do |format|
      if @user.update_with_password(params[:user])
        @product.destroy
      else
      end
      format.js
    end
  end

end
