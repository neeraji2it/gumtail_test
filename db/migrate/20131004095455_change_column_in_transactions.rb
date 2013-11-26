class ChangeColumnInTransactions < ActiveRecord::Migration
   def up
    change_column :transactions, :card_id, :string
  end

  def down
    change_column :transactions, :card_id, :integer
  end
end
