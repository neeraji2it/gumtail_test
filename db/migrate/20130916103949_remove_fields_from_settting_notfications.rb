class RemoveFieldsFromSetttingNotfications < ActiveRecord::Migration
  def up
  	remove_column :notifications,:mentions_you
    remove_column :notifications,:accepts_your_invitation
    remove_column :notifications,:comments_on_your_products
    remove_column :notifications,:product_is_trending
    remove_column :notifications,:subscribe_to_you
    remove_column :notifications,:recommends_your_product
    remove_column :notifications,:purchase_your_product

  end

  def down
  	add_column :notifications,:mentions_you,:boolean
    add_column :notifications,:accepts_your_invitation,:boolean
    add_column :notifications,:comments_on_your_products,:boolean
    add_column :notifications,:product_is_trending,:boolean
    add_column :notifications,:subscribe_to_you
    add_column :notifications,:recommends_your_product
    add_column :notifications,:purchase_your_product
  end
end
