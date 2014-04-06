class Api::V1::SurveyQuestionsController < ApplicationController
  respond_to :json

  def new
    respond_with survey_question
  end

  def create
    survey_question.answer = params[:survey_question][:answer]
    survey_question.save!
    respond_with survey_question, location: nil
  end

  private

  def survey_question
    @survey_question ||= current_user.surveys.find(params[:survey_id]).survey_questions.find(params[:id])
  end
end
