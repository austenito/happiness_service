class SurveyQuestion < ActiveRecord::Migration
  def change
    create_table :survey_questions do |t|
      t.integer :survey_id, index: true
      t.integer :question_id, index: true
      t.text :answer
      t.timestamps
    end
  end
end
