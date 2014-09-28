class Api::V1::QuestionsController < ApplicationController
  respond_to :json

  def index
    respond_with Question.all, each_serializer: Api::V1::QuestionSerializer, root: false
  end

  def create
    question = Question.create_from_params(question_params)
    respond_with question, { serializer: Api::V1::QuestionSerializer, location: nil, root: false }
  end

  private

  def question_params
    params.require(:question).permit(:type,  :absolute_index, :text, :freeform, :question_type, :parent_question_id, { responses: []})
  end
end
