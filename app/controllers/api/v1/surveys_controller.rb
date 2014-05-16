class Api::V1::SurveysController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :json

  def index
    respond_with Survey.all, { location: nil }
  end

  def show
    respond_with Survey.find(params[:id]), location: nil
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
