class AddAccountTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users,:account_activation_code,:string,:default => nil
  end
end
