class Api::V1::RootController < ApplicationController
  respond_to :json

  def index
    respond_with Object.new, serializer: Api::V1::RootSerializer
  end
end
