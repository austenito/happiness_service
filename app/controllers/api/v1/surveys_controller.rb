class Api::V1::SurveysController < ApplicationController
  respond_to :json

  def create
    respond_with Survey.generate(current_user), location: nil
  end
end
