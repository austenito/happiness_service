require 'spec_helper'

describe Api::V1::SurveysController do
  it "creates a survey with 5 unique questions" do
    5.times { create(:question) }
    response = post(:create, { format: :json })

    response.code.should == "201"
    parsed_response = JSON.parse(response.body)
    parsed_response['survey']['survey_questions'].count.should == 5
  end
end
