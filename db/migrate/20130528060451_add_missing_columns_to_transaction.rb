class AddMissingColumnsToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions,:date,:datetime
    add_column :transactions,:placed_by,:string
    add_column :transactions,:referred_by,:string
    add_column :transactions,:payment_status,:string
    add_column :transactions,:username,:string
    add_column :transactions,:email,:string
    add_column :transactions,:delivery_status,:string
    add_column :transactions,:transaction_type,:string
  end
end
