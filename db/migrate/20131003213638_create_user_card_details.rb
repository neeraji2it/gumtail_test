class CreateUserCardDetails < ActiveRecord::Migration
  def change
    create_table :user_card_details do |t|
      t.integer :user_id
      t.integer :card_id
      t.string  :card_type
      t.integer :last_4_digits 
      t.boolean :shipping_address_present, default: false
      t.string  :street_address
	  t.string  :city
	  t.string  :state
	  t.string  :post_code
	  t.string  :country

      t.timestamps
    end
  end
end