class AddIndexToStoresCustomAppearance < ActiveRecord::Migration
  def up
	  execute "CREATE INDEX stores_custom_appearance ON stores USING GIN(custom_appearance)"
	end

	def down
	  execute "DROP INDEX stores_custom_appearance"
	end
end
