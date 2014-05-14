module Api::V1::RootRepresenter
  include Roar::Representer::JSON::HAL

  property :question_types

  link :self do
    root_url + "api"
  end

  link :surveys do
    api_surveys_url
  end

  link :questions do
    api_questions_url
  end

  def question_types
    { boolean: 'BooleanQuestion', multiple_response: 'MultipleResponseQuestion' }
  end
end
