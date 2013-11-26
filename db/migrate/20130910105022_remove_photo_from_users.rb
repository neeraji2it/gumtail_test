class RemovePhotoFromUsers < ActiveRecord::Migration
  def up
  	remove_column :users,:photo_file_name 
  	remove_column :users,:photo_content_type 
  	remove_column :users,:photo_file_size  
  end

  def down
  	add_column :users,:photo_file_name,:string
  	add_column :users,:photo_file_size,:string
  	add_column :users,:photo_file_size,:integer 
  end
end
