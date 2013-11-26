class ApplicationController < ActionController::Base
  protect_from_forgery
  include UrlHelper  
  include ApplicationHelper
  before_filter :save_referer
  #before_filter :cors_preflight_check
  #after_filter :cors_set_access_control_headers
  before_filter :miniprofiler
  around_filter :set_time_zone, if: :current_user
    #allow signed in users
    def is_login
      unless current_user
        redirect_to ROOT_URL
      end
    end

    #after registering an account it will redirect to home page /home
    def after_sign_up_path_for(resource)
      if resource.is_a?(User)
        root_path
      end
    end

    #redirect after sign in
    def after_sign_in_path_for(resource_or_scope)
      if resource_or_scope.is_a?(User)
        resource_or_scope.update_user_drawer #In any case where the user bought something while he was logged out
        flash[:notice] = "Successfully Login!"
        root_path
      end
    end

    def save_referer
      unless session['referer']
        session['referer'] = request.env["HTTP_REFERER"] ? request.env["HTTP_REFERER"] : 'direct'
      end
    end

    def track_activity(trackable, action = params[:action])
      current_user.activities.create! action: action, trackable: trackable
    end

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Max-Age'] = "1728000"
    end

    def cors_preflight_check
      if request.method == :options
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
        headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, X-CSRF-Token'
        headers['Access-Control-Max-Age'] = '1728000'
        render :text => '', :content_type => 'text/plain'
      end
    end
  


  
  private

    def miniprofiler
      Rack::MiniProfiler.authorize_request
    end

    def load_store(controller)
      @current_store = Store.find_by_store_name(request.subdomain)
      set_theme(@current_store) if @current_store
      if @current_store.blank?
        flash[:error] = "Invalid Shop address!"
        redirect_to root_path
      else
        if controller == "product"
          @product = Product.find_by_random_no(params[:number])
          new_product_view
        elsif controller == "store"
          new_store_view
        end    
      end
    end

    def set_theme(store)
      if store.current_theme_id != 0 
        @theme = Theme.find(store.current_theme_id).theme_content 
      else
        @theme = store.custom_theme_content
      end
    end

    def new_product_view
      if !product_user?(@product)
        @product.product_views.create(product_id: @product.id, ip_address: request.remote_ip, owner_id: @product.store.user_id, referrer: session['referer'])
      end
    end

    def new_store_view
      if !store_user?(@current_store)
        @current_store.store_views.create(store_id: @current_store.id, ip_address: request.remote_ip, owner_id: @current_store.user_id, referrer: session['referer'])
      end
    end
  
    def set_time_zone(&block)
      Time.use_zone(current_user.timezone, &block)
    end

  end
