class Api::V1::QuestionsController < ApplicationController
  respond_to :json

  def index
    respond_with Question.all, represent_with: Api::V1::QuestionRepresenter
  end
end
