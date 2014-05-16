class SurveyQuestion < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question

  def text
    question.text
  end

  def type
    question.question_type
  end

  def boolean?
    type == "boolean"
  end

  def range?
    type == "range"
  end

  def multiple?
    type == "multiple_response"
  end
end
