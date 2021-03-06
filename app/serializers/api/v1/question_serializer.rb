class Api::V1::QuestionSerializer < ActiveModel::Serializer
  attributes :id, :question_type, :text, :responses, :key, :_links

  self.root false

  def _links
    [
      {
        'rel' => 'self',
        'href' => api_question_url(object),
        'method' => 'GET'
      }
    ]
  end
end
