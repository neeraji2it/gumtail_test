# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130617130335) do

  create_table "file_handlers", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "product_id", :default => 0
    t.boolean  "is_cover",   :default => false
    t.string   "file_name",                     :null => false
    t.string   "file_path",                     :null => false
    t.string   "file_type",                     :null => false
    t.string   "file_size",                     :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "file_handlers", ["product_id"], :name => "index_file_handlers_on_product_id"
  add_index "file_handlers", ["user_id"], :name => "index_file_handlers_on_user_id"

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "subscribe_to_you"
    t.boolean  "accepts_your_invitation"
    t.boolean  "comments_on_your_products"
    t.boolean  "product_is_trending"
    t.boolean  "mentions_you"
    t.boolean  "recommends_your_product"
    t.boolean  "purchase_your_product"
    t.boolean  "news"
    t.boolean  "tips"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "product_categories", :force => true do |t|
    t.string   "category"
    t.string   "category_type"
    t.string   "amount"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "product_categories", ["category"], :name => "index_product_categories_on_category"
  add_index "product_categories", ["category_type"], :name => "index_product_categories_on_type"


  create_table "products", :force => true do |t|
    t.integer  "store_id",                                         :null => false
    t.integer  "category_id",                                      :null => false
    t.string   "product_title",                                    :null => false
    t.string   "product_type",                                     :null => false
    t.text     "description",                                      :null => false
    t.integer  "quantity"
    t.boolean  "unlimited",                 :default => false
    t.integer  "views"
    t.string   "sales"
    t.string   "pricing"
    t.decimal  "amount"
    t.decimal  "amount_from"
    t.integer  "auction_id",                 :default => 0
    t.string   "random_no"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.string   "buyer_will_get"
    t.text     "custom_message"
  end

  create_table "recommendations", :force => true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "social_connections", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "token"
    t.string   "provider_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "stores", :force => true do |t|
    t.integer  "user_id"
    t.string   "store_name"
    t.text     "postage_info"
    t.text     "delivery_returns"
    t.text     "faqs"
    t.text     "more_info"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "subscribes", :force => true do |t|
    t.integer  "subscriber_id"
    t.integer  "publisher_id"
    t.string   "subscribe_status"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "transactions", :force => true do |t|
    t.string   "transaction_id"
    t.string   "amount"
    t.string   "card_type"
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "placed_by"
    t.string   "referred_by"
    t.string   "payment_status"
    t.string   "username"
    t.string   "email"
    t.string   "delivery_status"
    t.string   "transaction_type"
    t.integer  "order_number"
    t.integer  "quantity"
  end

  add_index "transactions", ["order_number"], :name => "index_transactions_on_order_number", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",  :null => false
    t.string   "encrypted_password",     :default => "",  :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "provider"
    t.string   "provider_id"
    t.text     "details"
    t.string   "token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.text     "bio"
    t.string   "location"
    t.string   "website"
    t.string   "gender"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "photo"
    t.string   "balance",                :default => "0"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
