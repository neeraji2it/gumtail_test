class CreateUserAddresses < ActiveRecord::Migration
  def change
    create_table :user_addresses do |t|
    	t.belongs_to :user
    	t.string :street
    	t.string :city
    	t.string :state
    	t.string :code

      t.timestamps
    end
  end
end
