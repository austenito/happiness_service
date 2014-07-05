class Api::V1::SurveyQuestionSerializer < ActiveModel::Serializer
  self.root false

  attributes :id, :text, :type, :responses, :answer, :freeform, :_links

  def _links
    {
      self: {
        href: api_survey_survey_question_url(object.survey, object)
      },
      survey: {
        href: api_survey_url(object.survey)
      },
      create: {
        href: api_survey_survey_questions_url(object.survey)
      },
      submit: {
        href: api_survey_survey_question_url(object.survey, object)
      }
    }
  end
end
