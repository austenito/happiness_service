module Api::V1::MultipleResponseQuestionRepresenter
  include Roar::Representer::JSON::HAL
  include Api::V1::SurveyQuestionRepresenter

  property :responses

  def responses
    self.question.questionable.responses
  end
end
