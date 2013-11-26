class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :transaction_id
      t.string :amount
      t.string :card_type
      t.integer :product_id
      t.integer :user_id

      t.timestamps
    end
  end
end
