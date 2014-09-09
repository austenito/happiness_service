class Api::V1::SurveySerializer < ActiveModel::Serializer

  attributes :id, :user_id, :_links, :completed
  has_many :survey_questions, serializer: Api::V1::SurveyQuestionSerializer
  self.root false

  def _links
    {
      self: {
        href: api_survey_url(object)
      },
      submit: {
        href: api_survey_survey_questions_url(object)
      }
    }
  end
end
