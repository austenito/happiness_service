require 'rails_helper'

describe Api::V1::UserSerializer do
  include Rails.application.routes.url_helpers

  before do
    Rails.application.routes.default_url_options[:host] = 'example.comm'
  end

  it 'returns a user' do
    user = create(:user)

    serializer = Api::V1::UserSerializer.new(user)
    expect(serializer.as_json).to match(a_hash_including(
       service_user_id: user.service_user_id,
       token: user.token
      )
    )
  end

  it 'returns a link to the user' do
    user = create(:user)
    serializer = Api::V1::UserSerializer.new(user)
    expect(serializer.as_json[:_links]).to match(a_hash_including(
        'href' => api_user_url,
        'rel' => 'self'
      )
    )
  end
end
