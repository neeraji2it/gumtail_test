class AddCustomAppearanceToStores < ActiveRecord::Migration
  def change
    add_column :stores, :custom_appearance, :hstore
  end
end
