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
    [
      {
        'rel' => 'self',
        'href' => api_survey_survey_question_url(object.survey, object),
        'method' => 'GET'
      },
      {
        'rel' => 'self',
        'href' => api_survey_survey_question_url(object.survey, object),
        'method' => 'PUT'
      },
      {
        'rel' => 'survey',
        'href' => api_survey_url(object.survey),
        'method' => 'GET'
      }
    ]
  end
end
