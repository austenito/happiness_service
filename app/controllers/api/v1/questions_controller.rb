class Api::V1::QuestionsController < ApplicationController
  respond_to :json

  def index
    respond_with Question.all, each_serializer: Api::V1::QuestionSerializer, root: false
  end
end
