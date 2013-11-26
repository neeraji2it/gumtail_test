class AddUniqueViewsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :unique_views, :integer, default: 0
  end
end
