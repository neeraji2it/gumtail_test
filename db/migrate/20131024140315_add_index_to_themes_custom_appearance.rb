class AddIndexToThemesCustomAppearance < ActiveRecord::Migration
	def up
		execute "CREATE INDEX themes_custom_appearance ON themes USING GIN(custom_appearance)"
	end

	def down
		execute "DROP INDEX themes_custom_appearance"
	end
end
