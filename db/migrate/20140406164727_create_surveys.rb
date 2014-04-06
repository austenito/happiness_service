class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer :user_id, index: true
      t.integer :survey_question_ids, array: true, default: []
      t.integer :last_responded_question
      t.boolean :completed, default: false
      t.timestamps
    end
  end
end
