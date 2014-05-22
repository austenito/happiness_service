module Api::V1::UserRepresenter
  include Roar::Representer::JSON::HAL

  property :id
  property :external_user_id
  property :token

  link :self do
    api_user_url(self)
  end
end
