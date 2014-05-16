class AddResponsesToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :responses, :string, array: true
    add_column :questions, :question_type, :string
  end
end
