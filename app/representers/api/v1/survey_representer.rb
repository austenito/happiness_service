module Api::V1::SurveyRepresenter
  include Roar::Representer::JSON::HAL

  property :id

  link :self do
    api_survey_url(self)
  end

  link :next do
    api_survey_survey_question_url(self, survey_questions.first)
  end
end
