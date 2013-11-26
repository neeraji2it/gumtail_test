class AddQuestionedIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :questioned_id, :integer
  end
end
