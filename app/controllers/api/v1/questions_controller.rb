class Api::V1::QuestionsController < ApplicationController
  respond_to :json

  def index
    respond_with Question.all, each_serializer: Api::V1::QuestionSerializer, root: false
  end

  def show
    respond_with Question.find(params[:id]), serializer: Api::V1::QuestionSerializer, root: false
  end

  def create
    question = Question.create!(question_type: question_params[:question_type],
                                text: question_params[:text],
                                responses: question_params[:responses],
                                key: question_params[:key])
    respond_with question, { serializer: Api::V1::QuestionSerializer, location: nil, root: false }
  end

  private

  def question_params
    params.require(:question).permit(:question_type, :text, :question_type, { responses: []}, :key)
  end
end
