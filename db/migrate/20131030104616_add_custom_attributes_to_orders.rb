class AddCustomAttributesToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :custom_attributes, :hstore
  end
end
