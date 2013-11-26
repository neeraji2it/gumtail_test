class ChangeQuantityInOrders < ActiveRecord::Migration
  def up
  	change_column :orders, :quantity, :integer, :default => 1
  end

  def down
  	change_column :orders, :quantity, :integer, :default => 0
  end
end
