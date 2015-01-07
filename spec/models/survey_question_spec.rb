require 'rails_helper'

describe SurveyQuestion do
  context 'before create' do
    it 'stamps responses from a question onto a survey question' do
      question = create(:question, responses: ['Toasted', 'Frozen'])
      survey_question = create(:survey_question, question: question)
      expect(survey_question.responses).to eq(['Toasted', 'Frozen'])
    end
  end
end
