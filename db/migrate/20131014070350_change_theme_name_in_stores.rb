class ChangeThemeNameInStores < ActiveRecord::Migration
  def up
  	remove_column :stores, :theme_name
  	add_column :stores, :theme_id, :integer
  end

  def down
  	rename_column :stores, :theme_id
  	add_column :stores, :theme_name, :string
  end
end
