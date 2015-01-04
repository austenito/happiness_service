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
        href: "#{api_user_url}{/id}{?query*}"
      },
      questions: {
        href: "#{api_questions_url}{/id}{?query*}"
      },
      survey_questions: {
        href: "#{api_questions_url}/surveys/{survey_id}/survey_questions{/id}{?query*}"
      }
    }
  end
end
