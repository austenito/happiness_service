module Api::V1::SurveyQuestionRepresenter
  include Roar::Representer::JSON::HAL

  property :id
  property :text
  property :type
  property :answer
  property :responses

  link :self do
    api_survey_survey_question_url(self.survey, self)
  end

  link :next do |args|
    next_question = self.survey.next_question
    if args[:show_next] && next_question
      api_survey_survey_question_url(self.survey, next_question)
    end
  end

  link :survey do
    api_survey_url(self.survey)
  end

  link :submit do
    api_survey_survey_questions_url(self.survey)
  end
end
