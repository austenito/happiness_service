class Api::V1::RootController < ApplicationController
  respond_to :json

  def index
    respond_with Survey.new, represent_with: Api::V1::RootRepresenter
  end
end
