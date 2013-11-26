class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.string :category
      t.string :category_type
      t.string :amount

      t.timestamps
    end
    add_index :product_categories, :category
    add_index :product_categories, :category_type
  end
end
