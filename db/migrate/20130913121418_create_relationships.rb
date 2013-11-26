class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :subscriber_id
      t.integer :publisher_id

      t.timestamps
    end
    add_index :relationships, :subscriber_id
    add_index :relationships, :publisher_id
    add_index :relationships, [:subscriber_id, :publisher_id], unique: true
  end
end
