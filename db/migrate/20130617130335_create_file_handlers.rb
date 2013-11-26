class CreateFileHandlers < ActiveRecord::Migration
  def change
    create_table :file_handlers do |t|
      t.integer :user_id, :null => false
      t.integer :product_id, :default => 0
      t.boolean	:is_cover, :default => false
      t.string  :file_name, :null => false
      t.string  :file_path, :null => false
      t.string  :file_type, :null => false
      t.string  :file_size, :null => false


      t.timestamps
    end
    add_index :file_handlers, :user_id
    add_index :file_handlers, :product_id
  end
end
