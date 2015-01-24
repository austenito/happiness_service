require 'rails_helper'

describe Api::V1::RootSerializer do
  include Rails.application.routes.url_helpers

  before do
    Rails.application.routes.default_url_options[:host] = 'example.comm'
  end

  it 'returns root url' do
    serializer = Api::V1::RootSerializer.new(Object.new)
    expect(serializer.as_json).to match(
      _links: a_hash_including(
        {
          href: root_url,
          rel: 'self',
          method: 'GET'
        }
      )
    )
  end

  it 'returns surveys url' do
    serializer = Api::V1::RootSerializer.new(Object.new)
    expect(serializer.as_json).to match(
      _links: a_hash_including(
        {
          href: "#{api_surveys_url}{/id}{?query*}",
          rel: 'surveys',
          method: 'GET'
        },
        {
          href: "#{api_surveys_url}",
          rel: 'surveys',
          method: 'POST'
        }
      )
    )
  end

  it 'returns users url' do
    serializer = Api::V1::RootSerializer.new(Object.new)
    expect(serializer.as_json).to match(
      _links: a_hash_including(
        {
          href: "#{api_user_url}{/id}{?query*}",
          rel: 'users',
          method: 'GET'
        },
        {
          href: "#{api_user_url}",
          rel: 'users',
          method: 'POST'
        }
      )
    )
  end

  it 'returns questions url' do
    serializer = Api::V1::RootSerializer.new(Object.new)
    expect(serializer.as_json).to match(
      _links: a_hash_including(
        {
          href: "#{api_questions_url}{/id}{?query*}",
          rel: 'questions',
          method: 'GET'
        },
        {
          href: "#{api_questions_url}",
          rel: 'questions',
          method: 'POST'
        }
      )
    )
  end

  it 'returns survey questions urls' do
    serializer = Api::V1::RootSerializer.new(Object.new)
    expect(serializer.as_json).to match(
      _links: a_hash_including(
        {
          rel: 'survey-questions',
          href: "#{api_questions_url}/surveys/{survey_id}/survey_questions{/id}{?query*}",
          method: 'GET'
        },
        {
          rel: 'survey-questions',
          href: "#{api_questions_url}/surveys/{survey_id}/survey_questions",
          method: 'POST'
        },
        {
          rel: 'survey-questions',
          href: "#{api_questions_url}/surveys/{survey_id}/survey_questions{/id}",
          method: 'PUT'
        },
        {
          rel: 'survey-questions-by-query',
          href: "#{api_questions_url}/survey_questions{?query*}",
          method: 'GET'
        }
      )
    )
  end
end
