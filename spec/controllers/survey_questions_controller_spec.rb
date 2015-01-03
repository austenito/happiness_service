require 'rails_helper'

describe Api::V1::SurveyQuestionsController do
  describe '#index' do
    before do
      @user = create(:user)
      set_headers(@user, request)
    end

    it 'returns all survey questions' do
      survey_question = build(:survey_question)
      survey = create(:survey, user: @user, survey_questions: [survey_question])

      response = get :index, { format: :json }
      expect(response.code).to eq("200")

      survey_questions = JSON.parse(response.body)['survey_questions']
      expect(survey_questions.first).to match(a_hash_including(
        'id' => survey_question.id
        )
      )
    end

    it 'returns all survey questions by question id' do
      survey_question = build(:survey_question)
      other_survey_question = create(:survey_question, question: build(:question))

      survey = create(:survey, user: @user, survey_questions: [survey_question])

      response = get :index, { question_id: survey_question.question.id, format: :json }
      expect(response.code).to eq("200")

      survey_questions = JSON.parse(response.body)
      expect(survey_questions.count).to eq(1)
      expect(survey_questions['survey_questions'].first).to match(a_hash_including(
        'id' => survey_question.id
        )
      )
    end

    it 'returns all survey questions by question key' do
      question = create(:question, key: 'poptarts')
      survey_question = build(:survey_question, question: question)
      other_survey_question = create(:survey_question, question: build(:question, key: 'something else'))
      survey = create(:survey, user: @user, survey_questions: [survey_question])

      response = get :index, { key: 'poptarts', format: :json }
      expect(response.code).to eq("200")

      survey_questions = JSON.parse(response.body)
      expect(survey_questions.count).to eq(1)
      expect(survey_questions['survey_questions'].first).to match(a_hash_including(
        'id' => survey_question.id
        )
      )
    end

    it 'returns all survey questions by survey id' do
      survey_question = build(:survey_question)
      other_survey_question = create(:survey_question)
      survey = create(:survey, user: @user, survey_questions: [survey_question])

      response = get :index, { survey_id: survey.id, format: :json }
      expect(response.code).to eq("200")

      survey_questions = JSON.parse(response.body)
      expect(survey_questions.count).to eq(1)
      expect(survey_questions['survey_questions'].first).to match(a_hash_including(
        'id' => survey_question.id
        )
      )
    end
  end

  describe '#show' do
    before do
      @user = create(:user)
      set_headers(@user, request)
    end

    it 'returns a survey question' do
      survey_question = build(:survey_question)
      survey = create(:survey, user: @user, survey_questions: [survey_question])

      response = get :show, { survey_id: survey.id, id: survey_question.id, format: :json }
      expect(response.code).to eq("200")

      survey_question_response = JSON.parse(response.body)
      expect(survey_question_response).to match(a_hash_including(
        'id' => survey_question.id
        )
      )
    end
  end

  describe '#create' do
    before do
      @user = create(:user)
      set_headers(@user, request)
    end

    it 'adds a survey question to a survey' do
      question = create(:question, text: 'How do you like your poptarts?')
      survey = create(:survey, user: @user)

      response = get :create, { survey_id: survey.id, survey_question: { question_id: question.id }, format: :json }
      expect(response.code).to eq("201")

      survey_question_response = JSON.parse(response.body)
      expect(survey_question_response).to match(a_hash_including(
        'text' => 'How do you like your poptarts?'
        )
      )
    end
  end

  describe '#update' do
    before do
      @user = create(:user)
      set_headers(@user, request)
    end

    it 'answers a survey question' do
      survey_question = build(:survey_question)
      survey = create(:survey, user: @user, survey_questions: [survey_question])

      response = get :update, { survey_id: survey.id, id: survey_question.id, survey_question: { answer: 'toasted' }, format: :json }
      expect(response.code).to eq("204")

      response = get :show, { survey_id: survey.id, id: survey_question.id, format: :json }
      survey_question_response = JSON.parse(response.body)
      expect(survey_question_response).to match(a_hash_including(
        'answer' => 'toasted'
        )
      )
    end
  end
end
