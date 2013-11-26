class AddPropertiesToFileHandlers < ActiveRecord::Migration
  def change
    add_column :file_handlers, :properties, :hstore
  end

end
