class AddOrderNumberToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :order_number, :integer
    add_index :transactions,:order_number,:unique => true
  end
end
