class SurveyQuestion < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question
  validates :answer, presence: true, on: :update

  def text
    question.text
  end

  def type
    question.question_type
  end

  def responses
    self.question.responses
  end

  def freeform
    self.question.freeform
  end
end
