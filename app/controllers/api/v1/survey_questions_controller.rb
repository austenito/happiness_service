class Api::V1::SurveyQuestionsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :json

  def show
    respond_with survey_question, show_next: false
  end

  def create
    survey_question.answer = params[:survey_question][:answer]
    survey_question.save!
    respond_with survey_question, { status: :created, location: nil, show_next: true }
  end

  private

  def survey_question
    @survey_question ||= current_user.surveys.find(params[:survey_id]).survey_questions.find(params[:id])
  end
end
