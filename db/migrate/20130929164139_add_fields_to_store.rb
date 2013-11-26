class AddFieldsToStore < ActiveRecord::Migration
  def change
  	add_column :stores, :views, :integer, default: 0
  	add_column :stores, :unique_views, :integer, default: 0
  end
end
