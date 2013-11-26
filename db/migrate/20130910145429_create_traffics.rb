class CreateTraffics < ActiveRecord::Migration
  def change
    create_table :traffics do |t|
      t.integer :store_id,:default => 0
      t.integer :product_id,:default => 0
      t.string  :ip_address
      t.integer :owner_id

      t.timestamps
    end
  end
end
