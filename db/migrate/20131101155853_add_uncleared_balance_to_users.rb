class AddUnclearedBalanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uncleared_balance, :decimal, :default => 0
  end
end
