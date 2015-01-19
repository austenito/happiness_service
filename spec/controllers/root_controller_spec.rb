require 'rails_helper'

describe Api::V1::RootController do
  describe '#index' do
    it 'returns the root' do
      user = create(:user)
      set_headers(user, request)
      response = get :index, format: :json
      expect(response.code).to eq("200")
      links = JSON.parse(response.body)['_links']
      expect(links.first).to match(a_hash_including(
        'rel' => 'self',
        'href' => root_url
      ))
    end
  end
end
