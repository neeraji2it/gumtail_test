class AddFieldsToTransaction < ActiveRecord::Migration
  def change
  	add_column :transactions, :payment_token, :string
  	add_column :transactions, :card_id, :integer
  	add_column :transactions, :last_4_digits, :string
  	add_column :transactions, :order_id, :integer
  end
end
