class StoresController < ApplicationController
  before_filter :is_login,:except => [:show]
  before_filter :correct_user_store,:only => [:edit,:update]
  before_filter(:only => [:show]) { load_store "store" }


  def new
    @store = Store.new
    @themes = Theme.all
  end

  #show page /stores/:number
  def show
    @products = @current_store.products
    render :layout => "custom"
  end

  #create a record for store in db /stores
  def create
    @user = current_user
    @themes = Theme.all
    @store = Store.new(params[:store])
    @store.user_id = @user.id
    @store.currency = params[:store][:currency]
    @store.store_url = root_url(:subdomain => @store.store_name != nil ? @store.store_name.split(' ').join('_').downcase : false)
    if @store.save
      track_activity @store
      flash[:notice] = "Store created successfully."
      redirect_to root_url(subdomain: @store.store_name)
    else
      flash[:error] = "Store creation failed."
      render :action => "new"
    end
  end

  #store edit form /stores/:id/edit
  def edit
    @store = Store.find(params[:id])
    @themes = Theme.all
  end

  #updating existing store record in db /stores/:id
  def update
    @store = Store.find(params[:id]) 
    @themes = Theme.all
    @store.store_url = root_url(:subdomain => params[:store][:store_name] != nil ? params[:store][:store_name].split(' ').join('_').downcase : false)
    if @store.update_attributes(params[:store])
      flash[:notice] = 'Updated successfully.'
      redirect_to edit_store_path(@store)
    else
      flash[:error] = 'Updation failed.'
      render :action => "edit"
    end
  end

  def custom_appearance_update
    @store = current_user.store
    if @store.update_attributes(params[:store])
      respond_to do |format|
        format.js
      end
    else 
      respond_to do |format|
        format.js { render "alert('Update failed')" }
      end
    end
  end

  def correct_user_store
    @store = Store.find params[:id]
    if @store.user_id != current_user.id
      flash[:error] = 'Its not your store'
      redirect_to root_path
    end
  end

  # /customise/:username?redirect_to=store sub domain or custom domain

  def customise
    username = params[:username]
    store_redirect = params[:redirect_to]
    @current_store = current_user.store
    if current_user.try(:username) != username
      flash[:error] = "Sorry you can't customise that shop!"
      redirect_to root_path
    else
      if @current_store.current_theme_id != 0 
        @theme = Theme.find(@current_store.current_theme_id).theme_content 
      else
        @theme = @current_store.custom_theme_content
      end
      render :layout => "customise"
    end
  end

  def update_theme_content
    @store = current_user.store
    @store.custom_theme_content  = params[:custom_html]
    @store.current_theme_id = 0
    if @store.save!
      respond_to do |format|
        format.json { render :json => { :success => true } }
      end
    end

  end

end
