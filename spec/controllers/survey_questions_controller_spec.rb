require 'spec_helper'

describe Api::V1::SurveyQuestionsController do
  it "returns a question" do
    user = create(:user)
    survey_question = create(:survey_question)
    survey = create(:survey, user: user, survey_questions: [survey_question])
    set_headers(user, request)

    response = get(:new, { survey_id: survey.id, id: survey_question.id, format: :json })

    parsed_response = JSON.parse(response.body)
    parsed_response['survey_question']['text'].should == survey_question.text
  end

  it "accepts a response" do
    user = create(:user)
    survey_question = create(:survey_question)
    survey = create(:survey, user: user, survey_questions: [survey_question])
    set_headers(user, request)

    response = post(:create, { survey_id: survey.id, id: survey_question.id, format: :json,
                               survey_question: { answer: 'space' } })
    parsed_response = JSON.parse(response.body)
    response.code.should == "201"
    parsed_response['survey_question']['answer'].should == 'space'
  end
end
