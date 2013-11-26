class RemoveShippingOptionIdFromOrders < ActiveRecord::Migration
  def up
  	remove_column :orders,:shipping_option_id
    remove_column :orders,:shipping 
    remove_column :orders,:offer_code_used
    add_column :orders,:shipping_price,:decimal
    add_column :orders,:amount_paid,:decimal
  end

  def down
  	add_column :orders,:shipping_option_id,:boolean
    add_column :orders,:shipping,:integer
    add_column :orders,:offer_code_used,:string
    remove_column :orders,:shipping_price
    remove_column :orders,:amount_paid
  end
end
