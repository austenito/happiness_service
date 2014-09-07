class AddRelatedQuestionsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :parent_question_id, :integer
  end
end
