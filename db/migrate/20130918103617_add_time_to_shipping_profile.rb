class AddTimeToShippingProfile < ActiveRecord::Migration
  def change
  	add_column :shipping_profiles, :time, :integer, default: 0
  end
end
