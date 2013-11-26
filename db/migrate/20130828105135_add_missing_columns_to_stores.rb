class AddMissingColumnsToStores < ActiveRecord::Migration
  def change
    add_column :stores,:street,:string
    add_column :stores,:city,:string
    add_column :stores,:state,:string
    add_column :stores,:zip_code,:string
    add_column :stores,:country,:string
    add_column :stores,:currency,:string
    add_column :stores,:timezone,:string
    add_column :stores,:terms_conditions,:boolean
  end
end