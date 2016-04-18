class SearchController < ApplicationController
  def index
    @stations = Station.find(params[:zip], params[:distance])
  end
end
