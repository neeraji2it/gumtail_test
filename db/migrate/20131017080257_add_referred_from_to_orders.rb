class AddReferredFromToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :referred_from, :string
  end
end
