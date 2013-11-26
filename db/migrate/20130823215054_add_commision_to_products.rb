class AddCommisionToProducts < ActiveRecord::Migration
  def change
    add_column :products, :commision, :integer
  end
end
