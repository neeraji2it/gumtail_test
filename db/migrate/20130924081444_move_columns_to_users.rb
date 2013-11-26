class MoveColumnsToUsers < ActiveRecord::Migration
  def up
    remove_column :stores,:city
    remove_column :stores,:street
    remove_column :stores,:state
    remove_column :stores,:zip_code
    remove_column :stores,:country
    remove_column :stores,:timezone
    add_column :users,:city,:string
    add_column :users,:state,:string
    add_column :users,:zip_code,:string
    add_column :users,:country,:string
    add_column :users,:localization,:string
    add_column :users,:street,:string
  end

  def down
    add_column :stores,:city,:string
    add_column :stores,:state,:string
    add_column :stores,:zip_code,:string
    add_column :stores,:country,:string
    add_column :stores,:timezone,:string
    add_column :stores,:street,:string
    remove_column :users,:city
    remove_column :users,:state
    remove_column :users,:zip_code
    remove_column :users,:country
    remove_column :users,:localization
    remove_column :users,:street
  end
end
