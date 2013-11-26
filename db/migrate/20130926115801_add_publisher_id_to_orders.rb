class AddPublisherIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :publisher_id, :integer
  end
end
