require 'rails_helper'

describe Api::V1::QuestionsController do
  describe '#index' do
    it 'returns all questions' do
      user = create(:user)
      set_headers(user, request)
      question = create(:question, text: 'How do you do?')
      question2 = create(:question, text: 'Do you like poptarts?')

      response = get :index, format: :json

      expect(response.code).to eq("200")

      questions = JSON.parse(response.body)
      expect(questions.first).to match(a_hash_including(
        'text' => 'How do you do?'
      ))
      expect(questions.last).to match(a_hash_including(
        'text' => 'Do you like poptarts?'
      ))
    end
  end

  describe '#show' do
    it 'returns the question' do
      user = create(:user)
      set_headers(user, request)
      question = create(:question, text: 'How do you do?')

      response = get :show, { id: question.id, format: :json }

      expect(response.code).to eq("200")

      question = JSON.parse(response.body)
      expect(question).to match(a_hash_including(
        'text' => 'How do you do?'
      ))
    end

    it 'returns the question by key' do
      user = create(:user)
      set_headers(user, request)
      question = create(:question, text: 'How do you do?', key: 'poptarts')

      response = get :show, { id: 'poptarts', format: :json }

      expect(response.code).to eq("200")

      question = JSON.parse(response.body)
      expect(question).to match(a_hash_including(
        'text' => 'How do you do?'
      ))
    end
  end

  describe '#create' do
    it 'creates a question' do
      user = create(:user)
      set_headers(user, request)
      data = {
        question: {
          question_type: 'multiple',
          text: 'Do you love poptarts?',
          responses: ['Yes', 'No'],
          key: 'poptarts'
        }
      }

      response = post :create, data.merge(format: :json)
      expect(response.code).to eq('201')

      question = JSON.parse(response.body)
      expect(question).to match(a_hash_including(
        'text' => 'Do you love poptarts?',
        'key' => 'poptarts'
      ))
    end
  end
end
