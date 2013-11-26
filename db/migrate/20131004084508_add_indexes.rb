class AddIndexes < ActiveRecord::Migration
  def up
    add_index :users, :first_name
    add_index :users, :last_name
    add_index :users, :username
    add_index :users, :balance
    add_index :notifications, :user_id
    add_index :social_connections, :user_id
    add_index :stores, :user_id
    add_index :stores, :store_url
    add_index :products, :store_id
    add_index :products, :category_id
    add_index :products, :product_title
    add_index :products, :product_type
    add_index :products, :views
    add_index :products, :random_no
    add_index :recommendations, :user_id
    add_index :recommendations, :product_id
    add_index :orders, :product_id
    add_index :product_custom_fields, :name
    add_index :product_custom_fields, :product_id
    add_index :shipping_profiles, :product_id
    add_index :traffics, :store_id
    add_index :traffics, :product_id
    add_index :traffics, :owner_id
    add_index :orders, :transaction_id
    add_index :orders, :referrer_id
    add_index :comments, :user_id
    add_index :comments, :content
    add_index :friends, :provider
    add_index :friends, :user_id
  end

  def down
    remove_index :users, :first_name
    remove_index :users, :last_name
    remove_index :users, :username
    remove_index :users, :balance
    remove_index :notifications, :user_id
    remove_index :social_connections, :user_id
    remove_index :stores, :user_id
    remove_index :stores, :store_url
    remove_index :products, :store_id
    remove_index :products, :category_id
    remove_index :products, :product_title
    remove_index :products, :product_type
    remove_index :products, :views
    remove_index :products, :random_no
    remove_index :recommendations, :user_id
    remove_index :recommendations, :product_id
    remove_index :orders, :transaction_id
    remove_index :product_custom_fields, :name
    remove_index :product_custom_fields, :product_id
    remove_index :shipping_profiles, :product_id
    remove_index :traffics, :store_id
    remove_index :traffics, :product_id
    remove_index :traffics, :owner_id
    remove_index :orders, :product_id
    remove_index :orders, :user_id
    remove_index :orders, :referrer_id
    remove_index :comments, :user_id
    remove_index :comments, :content
    remove_index :friends, :provider
    remove_index :friends, :user_id
  end
end
