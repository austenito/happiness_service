class Api::V1::SurveysController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :json

  def index
    respond_with Survey.last, { location: nil, represent_with: Api::V1::RootRepresenter }
  end

  def show
    respond_with current_user.surveys.find(params[:id]), location: nil
  end

  def create
    if params[:random]
      survey = Survey.generate(current_user)
    else
      survey = Survey.create(user: current_user)
    end
    respond_with survey, { status: :created, location: nil }
  end
end
