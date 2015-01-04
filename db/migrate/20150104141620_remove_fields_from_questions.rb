class RemoveFieldsFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :freeform
    remove_column :questions, :always_show
    remove_column :questions, :absolute_index
    remove_column :questions, :parent_question_id
  end
end
