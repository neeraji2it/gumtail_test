module ApplicationHelper
  include ProductsHelper
  include StoresHelper
  include ThemeHelper
  #devise methods 
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  #displaying errors for each field having validation in model
  def validation_error(message)
    if message.class.to_s == 'Array'
      message = message.join(",")
    end
    return !message.to_s.blank? ? ("<div class='form_error' style='color:red;margin-top:-12px;'>&nbsp;&nbsp;"+message.to_s+"</div>").html_safe : " "
  end

  #displaying errors for devise forms
  def devise_error_messages!
    flash_alerts = []
    error_key = 'errors.messages.not_saved'

    if !flash.empty?
      flash_alerts.push(flash[:error]) if flash[:error]
      flash_alerts.push(flash[:alert]) if flash[:alert]
      flash_alerts.push(flash[:notice]) if flash[:notice]
      error_key = 'devise.failure.invalid'
    end

    return "" if resource.errors.empty? && flash_alerts.empty?
    errors = resource.errors.empty? ? flash_alerts : resource.errors.full_messages

    messages = errors.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t(error_key, :count    => errors.count,
      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end


  def link_to_add_nested_fields(name, f, association, klasss, type) 
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    field = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_#{type}", f: builder)
    end
    link_to(name, '#', class: klasss, data: {id: id, :"#{type}"=> field.gsub("\n", "")}.symbolize_keys!)   
    end


    #playing uploaded product video
    def show_video(url)
      render :partial => 'products/video', :locals => { :url => url }
    end

    #if user is signed in
    def signed_in?
      !current_user.nil?
    end

    def auth
      redirect_to root_url, alert: "You must be signed in to access that page" unless signed_in?
    end

    def signed_out?
      current_user.nil?
    end

    def current_user?(user)
      if current_user
        return true if user.id === current_user.id
      end
    end

    def link_to_user_shop(user)
      if user.store.present?
        #remove from comment once we have correct domain instead of heroku url
        link_to("Visit shop", root_url(:subdomain =>user.store.store_name) )
        #link_to("Visit shop", store_path(user.store.id))
      else
        link_to("Visit shop", new_store_path)
      end
    end
    
    def present(object, klass = nil)
      klass ||= "#{object.class}Presenter".constantize
      presenter = klass.new(object, self)
      yield presenter if block_given?
      presenter
    end

    def price(price)
      number_to_currency(price)
      #number_with_precision(price, :precision => 2)
    end

    def sortable(column, title = nil)
      title ||= column.titleize
      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
      css_class = column == sort_column ? "#{sort_direction}" : nil
      link_to :sort => column, :direction => direction, :remote => true  do 
        "#{title} <div class=#{css_class}></div>".html_safe
      end
    end

    def product_request(product)
      return '' if product_user?(product)
      if product.sold_out
        if current_user and product.requested?(current_user.email)
          "<p> Your request has been sent.</p>".html_safe
        else
          "This product is current sold out. Really want it? <a href='#' class='sendRequest' data-dropdown='requestDrop'>Send a request </a>".html_safe
        end
      end
    end

    def product_price(product)
      #Free pricing has been removed.
      if product.pricing == "free"
        "FREE"
      elsif product.pricing == "pay_anything_from"
        "Pay anything from: +$ #{product.amount}"
      else
        "price: $ #{product.amount}"
      end

    end
  
  end
