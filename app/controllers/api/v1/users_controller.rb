class Api::V1::UsersController < ApplicationController
  respond_to :json
  before_filter :authenticate_user, only: [:show]

  def show
    respond_with user, serializer: Api::V1::UserSerializer
  end

  def create
    respond_with User.create!, { status: :created, location: nil, serializer: Api::V1::UserSerializer }
  end
end
