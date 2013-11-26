class AddCountryToUserAddress < ActiveRecord::Migration
  def change
    add_column :user_addresses, :country, :string
  end
end
