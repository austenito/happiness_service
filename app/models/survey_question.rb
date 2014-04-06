class SurveyQuestion < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question

  def text
    question.text
  end
end
