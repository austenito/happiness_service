require 'spec_helper'

describe Api::V1::SurveyQuestionsController do
  it "returns a question" do
    user = create(:user)
    survey_question = create(:survey_question, order_index: 1)
    next_survey_question = create(:survey_question, order_index: 2)
    survey = create(:survey, user: user, survey_questions: [survey_question, next_survey_question])
    set_headers(user, request)

    response = get(:show, { survey_id: survey.id, id: survey_question.id, format: :json })

    parsed_response = JSON.parse(response.body)
    parsed_response['text'].should == survey_question.text
    links = parsed_response['_links']
    links['self']['href'].should == api_survey_survey_question_url(survey, survey_question)
    links['next'].should_not be
  end

  it "accepts a response" do
    user = create(:user)
    survey_question = create(:survey_question, order_index: 1)
    next_survey_question = create(:survey_question, order_index: 2)
    survey = create(:survey, user: user, survey_questions: [survey_question, next_survey_question])
    set_headers(user, request)

    response = post(:create, { survey_id: survey.id, id: survey_question.id, format: :json,
                               survey_question: { answer: 'space' } })

    response.code.should == "201"
    parsed_response = JSON.parse(response.body)
    links = parsed_response['_links']
    links['next']['href'].should == api_survey_survey_question_url(survey, next_survey_question)
  end

  it "returns nil when last question is answered" do
    user = create(:user)
    survey_question = create(:survey_question, order_index: 1)
    survey = create(:survey, user: user, survey_questions: [survey_question])
    set_headers(user, request)

    response = post(:create, { survey_id: survey.id, id: survey_question.id, format: :json,
                               survey_question: { answer: 'space' } })

    response.code.should == "201"
    parsed_response = JSON.parse(response.body)
    links = parsed_response['_links']
    links['next'].should_not be
  end
end
