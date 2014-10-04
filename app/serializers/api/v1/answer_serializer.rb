class Api::V1::AnswerSerializer < ActiveModel::Serializer
  attributes :created_at, :answer, :_links
  self.root false

  def _links
    {
      self: {
        href: api_survey_survey_question_url(object.survey, object)
      }
    }
  end
end
