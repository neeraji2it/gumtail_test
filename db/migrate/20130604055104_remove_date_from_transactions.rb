class RemoveDateFromTransactions < ActiveRecord::Migration
  def up
    remove_column :transactions, :date
  end

  def down
    add_column :transactions, :date, :date
  end
end
