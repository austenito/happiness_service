class Api::V1::SurveySerializer < ActiveModel::Serializer

  attributes :id, :service_user_id, :_links, :completed
  has_many :survey_questions, serializer: Api::V1::SurveyQuestionSerializer
  self.root false

  def service_user_id
    object.user.service_user_id
  end

  def _links
    [
      {
        'href' => api_survey_url(object),
        'rel' => 'self'
      },
      {
        'href' => api_survey_survey_questions_url(object),
        'rel' => 'survey-question',
        'method' => 'post'
      },
      {
        'href' => api_survey_survey_questions_url(object),
        'rel' => 'survey-question',
        'method' => 'put'
      }
    ]
  end
end
