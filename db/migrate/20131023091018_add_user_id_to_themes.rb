class AddUserIdToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :user_id, :integer
  end
end
