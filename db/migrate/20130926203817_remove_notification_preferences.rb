class RemoveNotificationPreferences < ActiveRecord::Migration
  def up
  	remove_column :notifications,:subscribe_to_you
    remove_column :notifications,:comments_on_your_story
    remove_column :notifications,:product_is_featured
    remove_column :notifications,:recommends_your_product
    remove_column :notifications,:purchase_your_product
    remove_column :notifications,:request_sold_out_product

  end

  def down
  	add_column :notifications,:subscribe_to_you,:boolean,:default => true
    add_column :notifications,:comments_on_your_story,:boolean,:default => true
    add_column :notifications,:product_is_featured,:boolean,:default => true
    add_column :notifications,:recommends_your_product,:boolean,:default => true
    add_column :notifications,:purchase_your_product,:boolean,:default => true
    add_column :notifications,:request_sold_out_product,:boolean,:default => true
  end
end
