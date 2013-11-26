# == Schema Information
#
# Table name: orders
#
#  id                  :integer          not null, primary key
#  order_no            :string(255)      not null
#  transaction_id      :integer          default(0)
#  amount              :decimal(, )      not null
#  product_id          :integer          not null
#  product_type        :string(255)      not null
#  user_id             :integer          default(0)
#  referrer_id         :integer          default(0)
#  referrer_commission :decimal(, )      default(0.0)
#  quantity            :integer          default(0), not null
#  payment_status      :string(255)      default("processing")
#  full_name           :string(255)
#  email               :string(255)
#  shipping            :boolean          default(TRUE), not null
#  shipping_option_id  :integer          default(0)
#  street_address      :string(255)
#  city                :string(255)
#  post_code           :string(255)
#  shipping_service    :string(255)
#  tracking_id         :string(255)
#  offer_code_used     :string(255)
#  offer_discount_off  :decimal(, )
#  transaction_fee     :decimal(, )      not null
#  order_total         :decimal(, )      not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  publisher_id        :integer
#  shipped_at          :datetime
#  referred_from       :string(255)

class Order < ActiveRecord::Base
  serialize :custom_attributes, ActiveRecord::Coders::Hstore
  attr_accessible :product_id, :referrer_id, :quantity, :full_name, :email, :shipping, :shipping_option_id, :street_address, :city,
    :state,:post_code,:country,:shipping_service,:tracking_id,:offer_code_used, :referred_from, :stripe_card_token
  attr_accessor :stripe_card_token
  before_create { generate_order_number(:order_no) }
  belongs_to :product
  belongs_to :user
  has_one :transaction
  has_many :comments
  has_many :events, class_name: "OrderEvent"
  STATES = %w[processing dispatched completed canceled]
  delegate :processing?, :canceled?, :dispatched?, :completed?, to: :current_state
  validates_presence_of :product_id 
  validate :validate_custom_fields
  validate :validate_flexible_pricing
  
  def self.processing_orders
    joins(:events).where("order_events.id IN (SELECT MAX(id) FROM order_events GROUP BY order_id) AND order_events.state = 'processing'")
  end

  def self.canceled_orders
    joins(:events).where("order_events.id IN (SELECT MAX(id) FROM order_events GROUP BY order_id) AND order_events.state = 'canceled'")
  end

  def self.dispatched_orders
    joins(:events).where("order_events.id IN (SELECT MAX(id) FROM order_events GROUP BY order_id) AND order_events.state = 'dispatched'")
  end

  def self.completed_orders
    joins(:events).where("order_events.id IN (SELECT MAX(id) FROM order_events GROUP BY order_id) AND order_events.state = 'completed'")
  end

  def current_state 
    (events.last.try(:state) || STATES.first).inquiry
  end

  def cancel
    events.create! state: "canceled" if processing?
  end

  def dispatch
    events.create! state: "dispatched" if processing?
    #cron job to mark order event as complete 2 days after delivey date
  end


  def self.chart_data(start = 3.weeks.ago)
    total_prices = prices_by_day(start)
    (start.to_date..Date.today).map do |date|
      {
        created_at: date,
        price: total_prices[date] || 0
      }
    end
  end

  def self.prices_by_day(start)
    orders = where(created_at: start.beginning_of_day..Time.now)
    orders = orders.group("created_at")
    orders = orders.select("created_at, sum(amount) as total_price")
    orders.each_with_object({}) do |order, prices|
      prices[order.created_at.to_date] = order.total_price
    end
  end

   def save_with_product_id(user_id)
    #Updating protected fields manually
    product = Product.find(self.product_id) 
    #########################---VARS---#############################
    orderAmount = order_amount(product)
    discount = offer_discount(product)
    shippingFee = shipping_fee(product)
    paid = amount_calculation(orderAmount,shippingFee,discount)
    transactionFees = transaction_fees(orderAmount,discount)

    self.amount = orderAmount
    self.product_id = product.id
    self.product_type = product.product_type
    self.publisher_id = product.store.user_id
    self.user_id = user_id
    self.offer_discount_off = discount
    self.shipping_price = shippingFee
    self.amount_paid = paid
    self.transaction_fee = transactionFees
    self.order_total = order_total_calculations(paid,transactionFees)
    save!
  end

  def update_with_transaction(id)
    self.transaction_id = id
    self.payment_status = "paid"
    save!
  end

  def self.get_total_sales(user_id)
    where(publisher_id: user_id).sum(:order_total)
  end

  def validate_custom_fields
    product.fields.each do |field|
      if field.required? && self.name.blank?
        errors.add field.name, "must not be blank"
      end
    end
  end

  def validate_flexible_pricing
    amount_from = Product.find(self.product_id).amount_from
    if amount_from.present? and amount_from > self.amount
       errors.add :base, "Your price cannot be less than the asking price"
    end
  end

  %w[name shipping_option_id offer].each do |key|
    attr_accessible key
    
    define_method(key) do
      custom_attributes && custom_attributes[key]
    end
  
    define_method("#{key}=") do |value|
      self.custom_attributes = (custom_attributes || {}).merge(key => value)
    end
  end


  


protected
  
  def generate_order_number(col)
    begin
      self[col] = rand(36**4)
    end while Order.exists?(col => self[col])
  end

  def order_amount(product)
    product.amount * self.quantity
  end

  def offer_discount(product)
    product_offer = product.offers.where(code: self.offer)
    if product_offer.present?
      product_offer.quantity = product_offer.quantity - 1 
      product_offer.save
      return product_offer.amount_off
    else
      return 0
    end
  end

  def shipping_fee(product)
    self.shipping_option_id.present? ? product.sprofiles.where(id: self.shipping_option_id).first.cost * self.quantity : 0
  end

  def amount_calculation(amount,shipping,discount)
    amount + shipping - discount
  end

  
  def transaction_fees(amount,discount)
     (0.05 * (amount - discount)) + 0.30 
  end


  def order_total_calculations(paid,transaction_fee)
    paid - transaction_fee
  end


  #to do 
  #referrer_commision later
  #deal with the dfferent pricing methods
  #update referrer_id to referral_id and remove referral_commision from attr_accessible
  #total_amout goes to uncleared funds + total_amount(amount -referal-offere-etc)
  #cleared in 14 days.
  #order events

end
