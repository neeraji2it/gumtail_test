class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.boolean :subscribe_to_you
      t.boolean :accepts_your_invitation
      t.boolean :comments_on_your_products
      t.boolean :product_is_trending
      t.boolean :mentions_you
      t.boolean :recommends_your_product
      t.boolean :purchase_your_product
      t.boolean :news,:default => true
      t.boolean :tips,:default => true

      t.timestamps
    end
  end
end
