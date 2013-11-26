class ChangeColumnCommisionInProducts < ActiveRecord::Migration
	def up
	    change_column :products, :commision, :integer, :default => 10
	    change_column :products, :amount, :decimal, :default => 0
	    change_column :products, :amount_from, :decimal, :default => 0
	end

	def down
	    change_column :products, :commision, :integer, :default => nil
	    change_column :products, :amount, :decimal, :default => nil
	    change_column :products, :amount_from, :decimal, :default => nil
	end
end
