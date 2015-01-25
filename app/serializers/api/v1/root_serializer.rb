class Api::V1::RootSerializer < ActiveModel::Serializer

  attributes :_links
  self.root false

  def _links
    [
      {
        href: root_url,
        rel: 'self',
        method: 'GET'
      },
      {
        href: "#{api_surveys_url}{/id}{?query*}",
        rel: 'surveys',
        method: 'GET'
      },
      {
        href: "#{api_surveys_url}",
        rel: 'surveys',
        method: 'POST'
      },
      {
        href: "#{api_user_url}{/id}{?query*}",
        rel: 'users',
        method: 'GET'
      },
      {
        href: "#{api_user_url}",
        rel: 'users',
        method: 'POST'
      },
      {
        href: "#{api_questions_url}{/id}{?query*}",
        rel: 'questions',
        method: 'GET'
      },
      {
        href: "#{api_questions_url}",
        rel: 'questions',
        method: 'POST'
      },
      {
        href: "#{api_questions_url}/surveys/{survey_id}/survey_questions{/id}{?query*}",
        rel: 'survey-questions',
        method: 'GET'
      },
      {
        href: "#{api_questions_url}/surveys/{survey_id}/survey_questions",
        rel: 'survey-questions',
        method: 'POST'
      },
      {
        href: "#{api_questions_url}/surveys/{survey_id}/survey_questions{/id}",
        rel: 'survey-questions',
        method: 'PUT'
      },
      {
        href: "#{api_survey_questions_url}{?query*}",
        rel: 'survey-questions-by-query',
        method: 'GET'
      }
    ]
  end
end
