class Api::V1::QuestionSerializer < ActiveModel::Serializer
  attributes :id, :question_type, :text, :responses, :key, :_links

  self.root false

  def _links
    {
      self: {
        href: api_question_url(object)
      }
    }
  end
end
