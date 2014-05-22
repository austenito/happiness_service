class Api::V1::UsersController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :json

  def show
    respond_with User.find(params[:id])
  end

  def create
    token = Digest::SHA512.hexdigest(Time.now.to_s + "nyan")
    user = User.create(external_user_id: user_params[:user_id], token: token)
    respond_with user, { status: :created, location: nil }
  end

  private

  def user_params
    params.require(:user).permit(:user_id)
  end
end
