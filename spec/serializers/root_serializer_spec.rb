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
        self: { href: root_url }
      )
    )
  end

  it 'returns surveys url' do
    serializer = Api::V1::RootSerializer.new(Object.new)
    expect(serializer.as_json).to match(
      _links: a_hash_including(
        surveys: { href: "#{api_surveys_url}{/id}{?query*}" }
      )
    )
  end

  it 'returns users url' do
    serializer = Api::V1::RootSerializer.new(Object.new)
    expect(serializer.as_json).to match(
      _links: a_hash_including(
        users: { href: "#{api_user_url}{/id}{?query*}" }
      )
    )
  end

  it 'returns questions url' do
    serializer = Api::V1::RootSerializer.new(Object.new)
    expect(serializer.as_json).to match(
      _links: a_hash_including(
        questions: { href: "#{api_questions_url}{/id}{?query*}" }
      )
    )
  end

  it 'returns survey questions url' do
    serializer = Api::V1::RootSerializer.new(Object.new)
    expect(serializer.as_json).to match(
      _links: a_hash_including(
        survey_questions: { href: "#{api_questions_url}/surveys/{survey_id}/survey_questions{/id}{?query*}" }
      )
    )
  end
end
