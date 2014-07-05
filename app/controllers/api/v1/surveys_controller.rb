class Api::V1::SurveysController < ApplicationController
  respond_to :json

  def index
    respond_with Survey.all, { location: nil, each_serializer: Api::V1::SurveySerializer }
  end

  def show
    respond_with Survey.find(params[:id]), location: nil, serializer: Api::V1::SurveySerializer
  end

  def create
    user = User.find(params[:survey][:user_id])
    if params[:random]
      survey = Survey.generate(user)
    else
      survey = Survey.create(user: user)
    end
    respond_with survey, { status: :created, location: nil, serializer: Api::V1::SurveySerializer }
  end
end
