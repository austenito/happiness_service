module Api::V1::RangeQuestionRepresenter
  include Roar::Representer::JSON::HAL
  include Api::V1::SurveyQuestionRepresenter

  property :min
  property :max

  def min
    self.question.questionable.min if self.question
  end

  def max
    self.question.questionable.max if self.question
  end
end
