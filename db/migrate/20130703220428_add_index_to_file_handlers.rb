class AddIndexToFileHandlers < ActiveRecord::Migration
	def up
	  execute "CREATE INDEX file_handlers_properties ON file_handlers USING GIN(properties)"
	end

	def down
	  execute "DROP INDEX file_handlers_properties"
	end
end
