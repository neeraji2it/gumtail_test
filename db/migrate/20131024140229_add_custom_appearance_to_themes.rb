class AddCustomAppearanceToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :custom_appearance, :hstore
  end
end
