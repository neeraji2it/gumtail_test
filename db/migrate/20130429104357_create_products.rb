class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :store_id, :null => false
      t.integer :category_id, :null => false
      t.string  :product_title, :null => false
      t.string  :product_type, :null => false
      t.text    :description, :null => false
      t.integer :quantity
      t.boolean :unlimited, :default => false
      t.integer :views
      t.string  :sales
      t.string  :pricing
      t.decimal :amount
      t.decimal :amount_from
      t.integer :auction_id, :default => 0
      t.string  :random_no
      t.string  :buyer_will_get
      t.text    :custom_message

      t.timestamps
    end
  end
end
