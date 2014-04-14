require 'spec_helper'

describe Api::V1::SurveysController do
  it "creates a survey with 5 unique questions" do
    5.times { create(:question) }
    response = post(:create, { format: :json })

    response.code.should == "201"

    survey = Survey.new.extend(Api::V1::SurveyRepresenter).from_json(response.body)
    survey.links['self'].href.should == api_survey_url(survey)
    survey.links['next'].href.should == api_survey_survey_question_url(survey, survey.survey_questions.first)
  end

  it "returns a survey" do
    user = create(:user)
    survey = create(:survey, user: user)
    response = get(:show, { id: survey.id, format: :json })

    response.code.should == "200"
    survey = Survey.new.extend(Api::V1::SurveyRepresenter).from_json(response.body)
    survey.links['self'].href.should == api_survey_url(survey)
    survey.links['next'].href.should == api_survey_survey_question_url(survey, survey.survey_questions.first)
  end
end
