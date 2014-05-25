class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::ImplicitRender

  before_filter :authenticate

  def authenticate
    token = request.headers['API-TOKEN']
    head(401) unless ApiClient.find_by(token: token).present?
  end
end
