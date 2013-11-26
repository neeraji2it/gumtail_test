class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :card_details_id, :integer, default: 0
  end
end
