# This file is copied to spec/ when you run 'rails generate rspec:install'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'spec_helper'

Rails.env = 'test'

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end

def set_headers(user, request)
  api_client = ApiClient.find_or_create_by(name: 'test', token: 'test')
  request.headers['USER-TOKEN'] = user.token
  request.headers['SERVICE-USER-ID'] = user.service_user_id
  request.headers['API-TOKEN'] = api_client.token
end
