class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

    	t.integer  :order_id, null: false
        t.integer :user_id, null: false
        t.string  :content

      t.timestamps
    end
  end
end
