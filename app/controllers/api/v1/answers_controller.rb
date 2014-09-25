class Api::V1::AnswersController < ApplicationController
  respond_to :json

  def index
    survey_questions = SurveyQuestion.where(question_id: params[:question_id])
    respond_with survey_questions, { each_serializer: Api::V1::AnswerSerializer }
  end
end
