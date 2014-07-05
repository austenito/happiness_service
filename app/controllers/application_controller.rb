class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::ImplicitRender

  before_filter :authenticate

  def authenticate
    token = request.headers['API-TOKEN']
    head(401) unless ApiClient.find_by(token: token).present?
  end

  def default_url_options
    if Rails.env.production?
      super.merge(host: 'DEFAULT_HOST_URL:DEFAULT_HOST_PORT')
    else
      super
    end
  end
end
