class RemoveFieldsFromTransactions < ActiveRecord::Migration
  def up
  	remove_column :transactions,:transaction_id 
    remove_column :transactions,:amount
    remove_column :transactions,:product_id 
    remove_column :transactions,:user_id 
    remove_column :transactions,:placed_by
    remove_column :transactions,:referred_by 
    remove_column :transactions,:payment_status
    remove_column :transactions,:username 
    remove_column :transactions,:email 
    remove_column :transactions,:delivery_status
    remove_column :transactions,:transaction_type
    remove_column :transactions,:order_number
    remove_column :transactions,:quantity 
  end

  def down
  	add_column :transactions,:transaction_id, :string 
    add_column :transactions,:amount, :integer
    add_column :transactions,:product_id, :integer 
    add_column :transactions,:user_id, :integer 
    add_column :transactions,:placed_by, :string
    add_column :transactions,:referred_by, :string
    add_column :transactions,:payment_status, :stirng
    add_column :transactions,:username,:string 
    add_column :transactions,:email,:string 
    add_column :transactions,:delivery_status,:string
    add_column :transactions,:transaction_type,:string
    add_column :transactions,:order_number,:integer
    add_column :transactions,:quantity,:integer 
  end
end
