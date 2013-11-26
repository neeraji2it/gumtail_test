class AddPayoutEmailToStores < ActiveRecord::Migration
  def change
    add_column :stores, :payout_email, :string
    add_column :stores, :store_terms, :text
  end
end
