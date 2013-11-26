class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :user_id, default: 0
      t.integer :publisher_id, :null => false
      t.string  :email, :null => false
      t.integer :product_id, :null => false


      t.timestamps
    end
    add_index :requests, :publisher_id
  end
end
