class SurveyQuestion < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question

  def text
    question.text
  end

  def type
    question.questionable_type
  end

  def boolean?
    type == "BooleanQuestion"
  end

  def range?
    type == "RangeQuestion"
  end

  def multiple?
    type == "MultipleResponseQuestion"
  end
end
