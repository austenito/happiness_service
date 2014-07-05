class Api::V1::UsersController < ApplicationController
  respond_to :json

  def show
    respond_with User.find_by(external_user_id: params[:id]), serializer: Api::V1::UserSerializer
  end

  def create
    token = Digest::SHA512.hexdigest(Time.now.to_s + "nyan")
    user = User.create(external_user_id: user_params[:external_user_id], token: token)
    respond_with user, { status: :created, location: nil, serializer: Api::V1::UserSerializer }
  end

  private

  def user_params
    params.require(:user).permit(:external_user_id)
  end
end
