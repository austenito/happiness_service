class AddResponsesToSurveyQuestions < ActiveRecord::Migration
  def change
    add_column :survey_questions, :responses, :string, array: true
  end
end
