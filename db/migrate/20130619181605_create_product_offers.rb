class CreateProductOffers < ActiveRecord::Migration
  def change
    create_table :product_offers do |t|
      t.string 	:code
      t.decimal :amount_off
      t.integer :quantity
      t.integer :product_id, null: false

      t.timestamps
    end
    add_index :product_offers, :product_id
  end
end
