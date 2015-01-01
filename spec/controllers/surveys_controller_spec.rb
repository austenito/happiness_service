require 'rails_helper'

describe Api::V1::SurveysController do
  describe '#index' do
    it 'returns all surveys for a user' do
      user = create(:user)
      set_headers(user, request)
      survey = create(:survey, user: user)

      response = get :index, format: :json
      expect(response.code).to eq('200')

      surveys = JSON.parse(response.body)['surveys']
      expect(surveys.first).to match(a_hash_including(
        'id' => survey.id,
        'service_user_id' => user.service_user_id,
        )
      )
    end
  end

  describe '#show' do
    it 'returns a survey' do
      user = create(:user)
      set_headers(user, request)
      survey = create(:survey, user: user)

      response = get :show, { id: survey.id, format: :json }
      expect(response.code).to eq('200')

      returned_survey = JSON.parse(response.body)
      expect(returned_survey).to match(a_hash_including(
        'id' => survey.id,
        'service_user_id' => user.service_user_id,
      ))
    end
  end

  describe '#create' do
    before do
      @user = create(:user)
      set_headers(@user, request)
    end

    it 'creates an empty survey' do
      expect {
        post :create, format: :json
      }.to change(@user.surveys, :count).from(0).to(1)

      expect(@user.surveys.first.survey_questions.count).to eq(0)
    end

    it 'creates a random survey' do
      survey = create(:survey, user: @user)
      allow(Survey).to receive(:generate).with(@user).and_return(survey)

      response = post :create, { random: true, format: :json }
      expect(response.code).to eq("201")

      returned_survey = JSON.parse(response.body)
      expect(returned_survey).to match(a_hash_including(
        'service_user_id' => @user.service_user_id,
      ))
    end
  end
end
