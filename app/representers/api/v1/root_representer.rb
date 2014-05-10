module Api::V1::RootRepresenter
  include Roar::Representer::JSON::HAL

  link :self do
    root_url
  end

  # link :next do |args|
    # next_question = self.survey.next_question
    # if args[:show_next] && next_question
      # api_survey_survey_question_url(self.survey, next_question)
    # end
  # end

  # link :survey do
    # api_survey_url(self.survey)
  # end

  # link :submit do
    # api_survey_survey_questions_url(self.survey)
  # end
end
