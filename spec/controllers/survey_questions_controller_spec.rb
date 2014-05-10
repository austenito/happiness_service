# require 'spec_helper'

# describe Api::V1::SurveyQuestionsController do
  # it "returns a boolean question" do
    # user = create(:user)
    # boolean_question = create(:boolean_question)
    # survey_question = SurveyQuestion.new(question_id: boolean_question.question.id)
    # survey = create(:survey, user: user, survey_questions: [survey_question])
    # set_headers(user, request)

    # response = get(:show, { survey_id: survey.id, id: survey_question.id, format: :json })

    # survey_question_response = Happy::BooleanQuestion.new(JSON.parse(response.body))
    # survey_question_response.text.should == survey_question.text
    # survey_question_response.links.self.href.should == api_survey_survey_question_url(survey, survey_question)
    # survey_question_response.links.next.should_not be
  # end

  # it "returns a multiple response question" do
    # user = create(:user)
    # multiple_response_question = create(:multiple_response_question, responses: ['Nyan', 'Cat'])
    # survey_question = SurveyQuestion.new(question_id: multiple_response_question.question.id)
    # survey = create(:survey, user: user, survey_questions: [survey_question])
    # set_headers(user, request)

    # response = get(:show, { survey_id: survey.id, id: survey_question.id, format: :json })

    # survey_question = Happy::MultipleResponseQuestion.new(JSON.parse(response.body))
    # survey_question.responses =~ ['Nyan', 'Cat']
  # end

  # it "returns a range question" do
    # user = create(:user)
    # range_question = create(:range_question, min: 0, max: 100)
    # survey_question = SurveyQuestion.new(question_id: range_question.question.id)
    # survey = create(:survey, user: user, survey_questions: [survey_question])
    # set_headers(user, request)

    # response = get(:show, { survey_id: survey.id, id: survey_question.id, format: :json })

    # survey_question = Happy::RangeQuestion.new(JSON.parse(response.body))
    # survey_question.min.should == 0
    # survey_question.max.should == 100
  # end

  # it "accepts a response" do
    # user = create(:user)
    # survey_question = create(:survey_question, order_index: 1)
    # next_survey_question = create(:survey_question, order_index: 2)
    # survey = create(:survey, user: user, survey_questions: [survey_question, next_survey_question])
    # set_headers(user, request)

    # response = post(:create, { survey_id: survey.id, id: survey_question.id, format: :json,
                               # survey_question: { answer: 'space' } })

    # response.code.should == "201"
    # parsed_response = JSON.parse(response.body)
    # links = parsed_response['_links']
    # links['next']['href'].should == api_survey_survey_question_url(survey, next_survey_question)
  # end

  # it "returns nil when last question is answered" do
    # user = create(:user)
    # survey_question = create(:survey_question, order_index: 1)
    # survey = create(:survey, user: user, survey_questions: [survey_question])
    # set_headers(user, request)

    # response = post(:create, { survey_id: survey.id, id: survey_question.id, format: :json,
                               # survey_question: { answer: 'space' } })

    # response.code.should == "201"
    # parsed_response = JSON.parse(response.body)
    # links = parsed_response['_links']
    # links['next'].should_not be
  # end
# end
