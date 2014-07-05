class Api::V1::RootSerializer < ActiveModel::Serializer

  attributes :_links
  self.root false

  def _links
    {
      self: {
        href: root_url + 'api'
      },
      surveys: {
        href: api_surveys_url
      },
      users: {
        href: api_users_url
      },
      questions: {
        href: api_questions_url
      }
    }
  end
end
