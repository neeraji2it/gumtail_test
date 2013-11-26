class ChangeCardIdInUserCardDetails < ActiveRecord::Migration
  def up
    change_column :user_card_details, :card_id, :string
    change_column :user_card_details, :last_4_digits, :string
  end

  def down
    change_column :user_card_details, :card_id, :integer
    change_column :user_card_details, :last_4_digits, :integer
  end

end
