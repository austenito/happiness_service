module Api::V1::RootRepresenter
  include Roar::Representer::JSON::HAL

  link :self do
    root_url + "api"
  end

  link :surveys do
    api_surveys_url
  end

  link :users do
    api_users_url
  end

  link :questions do
    api_questions_url
  end
end
