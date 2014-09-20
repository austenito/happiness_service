class Api::V1::UsersController < ApplicationController
  respond_to :json

  def show
    respond_with User.find_by(service_user_id: params[:id]), serializer: Api::V1::UserSerializer
  end

  def create
    respond_with User.create!, { status: :created, location: nil, serializer: Api::V1::UserSerializer }
  end
end
