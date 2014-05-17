class SurveyQuestion < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question

  def text
    question.text
  end

  def type
    question.question_type
  end

  def responses
    self.question.responses
  end
end
