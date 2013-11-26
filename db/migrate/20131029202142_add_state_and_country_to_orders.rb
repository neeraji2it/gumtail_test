class AddStateAndCountryToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :state, :string
    add_column :orders, :country, :string
  end
end
