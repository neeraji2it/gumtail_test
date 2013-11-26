class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.text :theme_content, null: false
      t.timestamps
    end
  end
end
