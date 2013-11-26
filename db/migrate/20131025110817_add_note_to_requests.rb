class AddNoteToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :note, :string
  end
end
