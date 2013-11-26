class AddFieldToStore < ActiveRecord::Migration
  def change
    add_column :stores, :show_recommendations, :boolean
    add_column :stores, :ask_questions, :boolean
    add_column :stores, :ask_page_title, :string
  end
end
