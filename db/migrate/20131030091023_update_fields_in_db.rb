class UpdateFieldsInDb < ActiveRecord::Migration
  def up
  	remove_column :recommendations, :ref_id 
  	change_column :orders, :referrer_id, :string
  end

  def down
  	add_column :recommendations, :ref_id, :string
  	change_column :orders, :referrer_id, :integer
  end
end
