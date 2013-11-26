class AddSoldToProducts < ActiveRecord::Migration
  def change
  	add_column :products,:sold,:integer,:default => 0
  	add_column :products,:initial_quantity,:integer
  end
end
