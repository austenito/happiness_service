module Api::V1::SurveyQuestionRepresenter
  include Roar::Representer::JSON::HAL

  property :text
  property :answer

  link :self do
    api_survey_survey_question_url(self.survey, self)
  end

  link :next do |args|
    if args[:show_next]
      survey_questions = self.survey.survey_questions
      index = survey_questions.index(self)
      api_survey_survey_question_url(self.survey, survey_questions[index + 1])
    end
  end
end
