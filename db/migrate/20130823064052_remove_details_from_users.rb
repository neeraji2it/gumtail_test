class RemoveDetailsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users,:details
    add_column :users,:timezone,:string
    add_column :users,:verified,:boolean
    add_column :users,:picture,:string
  end

  def down
    add_column :users,:details,:text
    remove_column :users,:timezone
    remove_column :users,:verified
    remove_column :users,:picture
  end
end
