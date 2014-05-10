module Api::V1::SurveyRepresenter
  include Roar::Representer::JSON::HAL

  property :id
  collection :survey_questions, extend: SurveyQuestionRepresenter

  link :self do
    api_survey_url(self)
  end

  link :submit do
    api_survey_survey_questions_url(self)
  end

  link :next do
    if self.next_question
      api_survey_survey_question_url(self, self.next_question)
    end
  end
end
