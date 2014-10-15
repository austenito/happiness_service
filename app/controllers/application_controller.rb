class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::ImplicitRender

  before_filter :authenticate
  attr_accessor :user

  def authenticate
    client_token = request.headers['API-TOKEN']
    head(401) unless ApiClient.find_by(token: client_token).present?
  end

  def authenticate_user
    return @user if @user

    service_user_id = request.headers['SERVICE-USER-ID']
    user_token = request.headers['USER-TOKEN']
    @user = User.find_by(service_user_id: service_user_id, token: user_token)
    head(401) unless @user
  end

  def default_url_options
    if Rails.env.production?
      super.merge(host: 'DEFAULT_HOST_URL:DEFAULT_HOST_PORT')
    else
      super
    end
  end
end
