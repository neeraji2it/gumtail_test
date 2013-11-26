class AddReferalInfoToRecommendations < ActiveRecord::Migration
  def change
  	add_column :recommendations, :ref_id, :string, null: false
  	add_index :recommendations, :ref_id
  end
end
