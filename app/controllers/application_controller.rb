class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::ImplicitRender

  before_filter :authenticate
  attr_reader :current_user

  private

  def authenticate
    @current_user = User.find_by(api_token: request.headers['USER_TOKEN'])
  end
end
