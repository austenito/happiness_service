class Api::V1::QuestionsController < ApplicationController
  respond_to :json

  def index
    respond_with Question.all, each_serializer: Api::V1::QuestionSerializer, root: false
  end

  def show
    if params[:id].to_i == 0
      respond_with Question.find_by(key: params[:id]), serializer: Api::V1::QuestionSerializer, root: false
    else
    respond_with Question.find(params[:id]), serializer: Api::V1::QuestionSerializer, root: false
    end
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
