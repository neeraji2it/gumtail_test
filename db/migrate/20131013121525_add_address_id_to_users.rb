class AddAddressIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_address_id, :integer, default: 0
    remove_column :users, :street
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :zip_code
  end
end
