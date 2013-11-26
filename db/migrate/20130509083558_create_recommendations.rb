class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :product_id
      t.integer :user_id

      t.timestamps
    end
  end
end
