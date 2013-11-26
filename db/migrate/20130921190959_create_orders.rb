class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.string  :order_no, null: false
        t.integer :transaction_id, default: 0
        t.decimal :amount, null: false
        t.integer :product_id, null: false
        t.string  :product_type, null: false
        t.integer :user_id, default: 0
        t.integer :referrer_id, default: 0
        t.decimal :referrer_commission, default: 0
        t.integer :quantity, null: false, default: 0
        t.string  :payment_status,default: "processing"
        t.string  :full_name
        t.string  :email
        t.string  :delivery_status, null: false
        t.boolean :shipping, null: false, default: true
        t.integer :shipping_option_id, default: 0
        t.string  :street_address
        t.string  :city
        t.string  :state
        t.string  :post_code
        t.string  :shipping_service
        t.string  :tracking_id
        t.string  :offer_code_used
        t.decimal :offer_discount_off
        t.decimal :transaction_fee, null: false
        t.decimal :order_total, null: false

        t.timestamps
    end
  end
end
