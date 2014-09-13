class Api::V1::RootSerializer < ActiveModel::Serializer

  attributes :_links
  self.root false

  def _links
    {
      self: {
        href: root_url
      },
      surveys: {
        href: 'surveys'
      },
      users: {
        href: 'users'
      },
      questions: {
        href: 'questions'
      }
    }
  end
end
