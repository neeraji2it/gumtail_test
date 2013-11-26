class AddAndRemoveFieldsFromOrders < ActiveRecord::Migration
  def up
  	add_column :orders, :shipped_at, :timestamp
  	remove_column :orders, :delivery_status

  end
  def down
  	remove_column :orders, :shipped_at
  	add_column :orders, :delivery_status, :string
  end
end
