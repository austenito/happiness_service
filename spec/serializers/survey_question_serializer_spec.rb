require 'rails_helper'

describe Api::V1::SurveyQuestionSerializer do
  include Rails.application.routes.url_helpers

  before do
    Rails.application.routes.default_url_options[:host] = 'example.comm'
  end

  it 'returns a survey question' do
    question = build(
      :question,
      text: 'Do you like poptarts?',
      question_type: 'boolean',
      key: 'poptarts'
    )
    survey_question = build(:survey_question, question: question)
    survey = create(:survey, survey_questions: [survey_question])

    serializer = Api::V1::SurveyQuestionSerializer.new(survey_question)

    expect(serializer.as_json).to match(a_hash_including(
        id: survey_question.id,
        text: 'Do you like poptarts?',
        question_type: 'boolean',
        key: 'poptarts',
        question_id: question.id
      )
   )
  end

  it 'returns link for survey question' do
    survey_question = build(:survey_question)
    survey = create(:survey, survey_questions: [survey_question])

    serializer = Api::V1::SurveyQuestionSerializer.new(survey_question)

    expect(serializer.as_json[:_links]).to match(
      a_hash_including(
        'href' => api_survey_survey_question_url(survey, survey_question),
        'rel' => 'self'
      )
    )
  end

  it 'returns link to update a survey question' do
    survey_question = build(:survey_question)
    survey = create(:survey, survey_questions: [survey_question])

    serializer = Api::V1::SurveyQuestionSerializer.new(survey_question)

    expect(serializer.as_json[:_links]).to match(
      a_hash_including(
        'href' => api_survey_survey_question_url(survey, survey_question),
        'rel' => 'self',
        'method' => 'put'
      )
    )
  end

  it 'returns link to survey question survey' do
    survey_question = build(:survey_question)
    survey = create(:survey, survey_questions: [survey_question])

    serializer = Api::V1::SurveyQuestionSerializer.new(survey_question)

    expect(serializer.as_json[:_links]).to match(
      a_hash_including(
        'href' => api_survey_url(survey),
        'rel' => 'survey'
      )
    )
  end
end
