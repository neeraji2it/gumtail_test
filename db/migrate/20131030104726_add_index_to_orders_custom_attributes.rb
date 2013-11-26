class AddIndexToOrdersCustomAttributes < ActiveRecord::Migration
	def up
	  execute "CREATE INDEX orders_custom_attributes ON orders USING GIN(custom_attributes)"
	end

	def down
	  execute "DROP INDEX orders_custom_attributes"
	end
end
