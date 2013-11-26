class AddStoreUrlToStores < ActiveRecord::Migration
  def change
    add_column :stores,:store_url,:string
  end
end