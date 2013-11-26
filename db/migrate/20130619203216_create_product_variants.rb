class CreateProductVariants < ActiveRecord::Migration
  def change
    create_table :product_variants do |t|
      t.string  :name
      t.string  :option
      t.decimal :price_change
      t.integer :quantity
      t.integer :product_id, null: false

      t.timestamps
    end
    add_index :product_variants, :product_id
    add_index :product_variants, :name
  end
end
