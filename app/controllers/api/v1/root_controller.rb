class Api::V1::RootController < ApplicationController
  respond_to :json
  include Roar::Rails::ControllerAdditions

  def index
    respond_with Object.new, represent_with: Api::V1::RootRepresenter
  end
end
