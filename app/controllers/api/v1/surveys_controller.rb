class Api::V1::SurveysController < ApplicationController
  respond_to :json
  before_filter :authenticate_user

  def index
    respond_with user.surveys, { location: nil, each_serializer: Api::V1::SurveySerializer }
  end

  def show
    respond_with user.surveys.find(params[:id]), location: nil, serializer: Api::V1::SurveySerializer
  end

  def create
    if params[:random]
      survey = Survey.generate(user)
    else
      survey = user.surveys.create
    end
    respond_with survey, { status: :created, location: nil, serializer: Api::V1::SurveySerializer }
  end
end
