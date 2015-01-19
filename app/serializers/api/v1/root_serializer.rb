class Api::V1::RootSerializer < ActiveModel::Serializer

  attributes :_links
  self.root false

  def _links
    [
      {
        href: root_url,
        rel: 'self'
      },
      {
        href: "#{api_surveys_url}{/id}{?query*}",
        rel: 'surveys'
      },
      {
        href: "#{api_user_url}{/id}{?query*}",
        rel: 'users'
      },
      {
        href: "#{api_questions_url}{/id}{?query*}",
        rel: 'questions'
      },
      {
        href: "#{api_questions_url}/surveys/{survey_id}/survey_questions{/id}{?query*}",
        rel: 'survey-survey-questions'
      },
      {
        href: "#{api_questions_url}/survey_questions{?query*}",
        rel: 'survey-questions'
      }
    ]
  end
end
