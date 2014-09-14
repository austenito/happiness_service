class Api::V1::SurveyQuestionSerializer < ActiveModel::Serializer
  self.root false

  attributes :id, :text, :type, :responses, :answer, :freeform, :_links

  def _links
    {
      self: {
        href: api_survey_survey_question_path(object.survey, object)
      },
      post: {
        href: api_survey_survey_questions_url(object.survey)
      },
      put: {
        href: api_survey_survey_question_path(object.survey, object)
      },
      survey: {
        href: api_survey_path(object.survey)
      }
    }
  end
end
