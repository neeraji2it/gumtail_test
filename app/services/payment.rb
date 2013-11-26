require 'active_model'
class Payment 
	include ActiveModel::Validations
	#validates_presence_of :user_id, :product_id 

	def initialize(params, user_id) 
		if create_order(params, user_id)
			@user = (user_id != 0) ? User.find(user_id) : nil
			@token = params[:stripe_card_token]
			payee_type
		end
	end

	def create_order(params, user_id)
		@order = Order.new(params)
		@order.save_with_product_id(user_id)
	rescue => e
	  self.errors.add :base, e.message
	  false
	end

	def save
		if self.errors.blank?
	      return @order
	    else
	      return false
	    end
	end

	def payee_type
        if @user.present?
			@user.card_details_id == 0 ? new_payee : existing_payee
		else
			new_payee 
		end
	end

	def completed?
    	return true if self.errors.blank?
  	end
	
private
	def new_payee
	  if @token.blank?
	  	self.errors.add :base, "We're doing something wrong -- this isn't supposed to happen, Please try again."
	  end
	  # Create new Customer
	  customer = Stripe::Customer.create(
	    email: @order.email,
	    card: @token
	  )
	  charge_card(customer)

	  rescue Stripe::InvalidRequestError => e
	      Rails.logger.error "Stripe error while creating customer: #{e.message}"
		  false
	end

	def existing_payee 
		return false if !@user.present?
	      if @user.card_details_id == 0
	      	self.errors.add :base, "We don't seem to have your card details, please click the enter it manually link."
	      end
	      customer = Stripe::Customer.retrieve(@user.card.card_id)
	      charge_card(customer)

	      rescue Stripe::InvalidRequestError => e
		      Rails.logger.error "Stripe error while charging your card: #{e.message}"
			  self.errors.add :base, "There was a problem with your credit card. Please click the enter it manually."
			  false
	end

	def charge_card(customer)
	    amount = (@order.amount_paid * 100).to_i
	    # Charge the Customer instead of the card
	    #account for free and flexible pricing
	    charge = Stripe::Charge.create(
	        amount: amount,
	        currency: "gbp",
	        customer: customer.id
	    )
	    save_transaction(charge)
    end

    def save_transaction(charge)
	    if @user.present? 
	    	if @user.card_details_id == 0
	    		save_card_details(charge)
	    	end
			if @user.user_address_id == 0
	    		save_user_address
	    	end
	    end
	    #updating transaction protected fields manually
	    transaction = Transaction.create(order_id: @order.id)
	    transaction.payment_token = @token
	    transaction.card_id = charge.card.customer
	    transaction.card_type = charge.card.type
	    transaction.last_4_digits = charge.card.last4
	    transaction.email = @order.email
	    transaction.save!
	    if charge.paid
	      update_order(transaction.id)
	    end

  end

  def save_card_details(charge)
  	UserCardDetails.find_or_create_by_user_id(@user.id) do |card|
        card.card_id = charge.card.customer
        card.card_type = charge.card.type
        card.last_4_digits = charge.card.last4
        card.save!
        update_user_card_details(card.id)
    end 
  end

  def save_user_address
  	UserAddress.find_or_create_by_user_id(@user.id) do |add|
  		add.street = @order.street_address
  		add.city  = @order.city
  		add.state = @order.state
  		add.code = @order.post_code
  		add.country = @order.country
  		add.save!
  		update_user_address_details(add.id)
  	end
  end

  def update_user_card_details(card_id)
  	@user.update_user_card_details_id(card_id)
  end

  def update_user_address_details(add_id)
  	@user.update_user_address_details(add_id)
  end

  def update_order(id)
  	@order.update_with_transaction(id)
  end


end #class end



