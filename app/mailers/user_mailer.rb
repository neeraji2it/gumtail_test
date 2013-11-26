class UserMailer < ActionMailer::Base
  include Sidekiq::Mailer
  default from: "from@example.com"
  
  def confirmation_instructions(user)
    @user = user
    @email = user.email
    mail(:to => @email,:subject => 'Confirmation instructions')
  end
  
  def subscribe(user_email, subscriber)
  	@subscriber = subscriber
  	mail to: user_email, subject: 'You have a new subscriber'
  end

  def purchase(user,order)
  	@user = user
    @order = order
  	@product = @order.product
    @shipping = @product.sprofiles.find(Array(@order).first.custom_attributes['shipping_option_id'])
  	mail to: @user.email, subject: "BOOM! You have recieved an order for #{@product.product_title}"
  end

  def order_confirmation(order)
  	@order = order
    @product = @order.product
  	mail to: @order.email, subject: "Your order details"
  end

  def product_request(email, product)
    @product = product
    mail to: email, subject: "You have a new request"
  end
  
  def send_connection_notifications(friend,name)
    @user = friend.user
    @provider = friend.provider
    @name = name
    mail to: friend.user.email, subject: "Your #{@provider} acquaintance #{@name} just joined the site", body: ""
  end
  def order_comment(email,order,by)
    @order = order
    @by = by
    mail to: email, subject: "A new comment!"
  end

end
