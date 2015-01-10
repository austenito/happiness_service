class Api::V1::SurveyQuestionSerializer < ActiveModel::Serializer
  self.root false

  attributes(
    :id,
    :text,
    :question_type,
    :responses,
    :answer,
    :_links,
    :created_at,
    :key,
    :question_id
  )

  def key
    object.question.key
  end

  def _links
    {
      self: {
        href: api_survey_survey_question_url(object.survey, object)
      },
      put: {
        href: api_survey_survey_question_url(object.survey, object)
      },
      survey: {
        href: api_survey_url(object.survey)
      }
    }
  end
end
