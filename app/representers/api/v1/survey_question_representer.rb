module Api::V1::SurveyQuestionRepresenter
  include Roar::Representer::JSON::HAL

  property :text
  property :answer

  link :self do
    api_survey_survey_question_url(self.survey, self)
  end

  link :next do |args|
    next_question = self.survey.next_question(self.order_index)
    if args[:show_next] && next_question
      api_survey_survey_question_url(self.survey, next_question)
    end
  end
end
