class Api::V1::QuestionsController < ApplicationController
  respond_to :json
  include Roar::Rails::ControllerAdditions

  def index
    questions = if params[:type]
      Question.where(questionable_type: params['type'])
    else
      Question.all
    end
    respond_with questions
  end
end
