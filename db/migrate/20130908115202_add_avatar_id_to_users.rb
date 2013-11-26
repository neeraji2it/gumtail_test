class AddAvatarIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users,:avatar_id,:integer,:default => 0
  end
end
