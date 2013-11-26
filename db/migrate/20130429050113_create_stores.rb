class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.integer :user_id
      t.string :store_name
      t.text :postage_info
      t.text :delivery_returns
      t.text :faqs
      t.text :more_info

      t.timestamps
    end
  end
end
