require 'rails_helper'

describe Api::V1::SurveySerializer do
  include Rails.application.routes.url_helpers

  before do
    Rails.application.routes.default_url_options[:host] = 'example.comm'
  end

  it 'returns a survey' do
    user = create(:user)
    survey = create(:survey, survey_questions: [], user: user)

    serializer = Api::V1::SurveySerializer.new(survey)

    expect(serializer.as_json).to match(a_hash_including(
        id: survey.id,
        service_user_id: user.service_user_id,
        completed: true,
        survey_questions: []
      )
   )
  end

  it 'returns links for survey' do
    user = create(:user)
    survey = create(:survey, user: user)

    serializer = Api::V1::SurveySerializer.new(survey)

    expect(serializer.as_json[:_links]).to match(
      a_hash_including(
        'href' => api_survey_url(survey),
        'rel' => 'self',
        'method' => 'GET'
      )
    )
  end

  it 'returns link to add survey questions' do
    user = create(:user)
    survey = create(:survey, user: user)

    serializer = Api::V1::SurveySerializer.new(survey)

    expect(serializer.as_json[:_links]).to match(
      a_hash_including(
        'href' => api_survey_survey_questions_url(survey),
        'rel' => 'survey-questions',
        'method' => 'POST'
      )
    )
  end
end
