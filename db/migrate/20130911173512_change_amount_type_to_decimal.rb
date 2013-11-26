class ChangeAmountTypeToDecimal < ActiveRecord::Migration
  def up
  connection.execute(%q{
    alter table transactions
    alter column amount
    type decimal using cast(amount as decimal)
  })
  end
end
