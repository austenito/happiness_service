class Api::V1::RootSerializer < ActiveModel::Serializer

  attributes :_links
  self.root false

  def _links
    {
      self: {
        href: root_url
      },
      surveys: {
        href: "#{api_surveys_url}{/id}{?query*}"
      },
      users: {
        href: "#{api_users_url}{/id}{?query*}"
      },
      questions: {
        href: "#{api_questions_url}{/id}{?query*}"
      },
      survey_questions: {
        href: "#{api_questions_url}{/question_id}/survey_questions{?query*}"
      }
    }
  end
end
