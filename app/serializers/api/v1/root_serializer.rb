class Api::V1::RootSerializer < ActiveModel::Serializer

  attributes :_links
  self.root false

  def _links
    {
      self: {
        href: root_url
      },
      surveys: {
        href: 'api/surveys'
      },
      users: {
        href: 'api/users'
      },
      questions: {
        href: 'api/questions'
      }
    }
  end
end
