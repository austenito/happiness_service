class Api::V1::SurveySerializer < ActiveModel::Serializer

  attributes :id, :service_user_id, :_links, :completed
  has_many :survey_questions, serializer: Api::V1::SurveyQuestionSerializer
  self.root false

  def service_user_id
    object.user.service_user_id
  end

  def _links
    {
      self: {
        href: api_survey_url(object)
      },
      survey_questions: {
        post: {
          href: api_survey_survey_questions_url(object)
        },
        put: {
          href: api_survey_survey_questions_url(object)
        }
      }
    }
  end
end
