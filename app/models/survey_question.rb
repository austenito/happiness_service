class SurveyQuestion < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question
  validates :answer, inclusion: { in: [true, false, "true", "false"]}, on: :update, if: "question.boolean?"
  validates :answer, presence: true, on: :update, unless: "question.boolean?"

  scope :ordered_by_index, order('order_index ASC')

  def text
    question.text
  end

  def question_type
    question.question_type
  end

  def responses
    self.question.responses
  end
end
