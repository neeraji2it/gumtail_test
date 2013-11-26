class AddThemeToStore < ActiveRecord::Migration
  def change
    add_column :stores, :theme_name, :string
    add_column :stores, :custom_theme_content, :text
  end
end
