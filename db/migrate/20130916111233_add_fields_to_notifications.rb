class AddFieldsToNotifications < ActiveRecord::Migration
  def change
  	add_column :notifications,:subscribe_to_you,:boolean,:default => true
    add_column :notifications,:comments_on_your_story,:boolean,:default => true
    add_column :notifications,:product_is_featured,:boolean,:default => true
    add_column :notifications,:recommends_your_product,:boolean,:default => true
    add_column :notifications,:purchase_your_product,:boolean,:default => true
    add_column :notifications,:request_sold_out_product,:boolean,:default => true
    add_column :notifications,:email_subscribe_to_you,:boolean,:default => true
    add_column :notifications,:email_comments_on_your_story,:boolean,:default => true
    add_column :notifications,:email_product_is_featured,:boolean,:default => true
    add_column :notifications,:email_recommends_your_product,:boolean,:default => true
    add_column :notifications,:email_purchase_your_product,:boolean,:default => true
    add_column :notifications,:email_request_sold_out_product,:boolean,:default => true
  end
end
