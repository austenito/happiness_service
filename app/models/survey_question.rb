class SurveyQuestion < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question

  def text
    question.text
  end

  def type
    question.questionable_type
  end
end
