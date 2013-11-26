class AddFieldsToStores < ActiveRecord::Migration
  def up
  	add_column :stores, :original_theme_id, :integer, default: 0
    add_column :stores, :current_theme_id, :integer, default: 0
    remove_column :stores, :theme_id 
  end
  def down
  	remove_column :stores, :original_theme_id
    remove_column :stores, :current_theme_id
    add_column :stores, :theme_id, :integer
  end
end
