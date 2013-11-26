class CreateShippingProfiles < ActiveRecord::Migration
  def change
    create_table :shipping_profiles do |t|
      t.string  :option
      t.decimal :cost
      t.integer :product_id

      t.timestamps
    end
#    add_index :shipping_profiles, :profile_name
  end
end
