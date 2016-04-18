class SearchController < ApplicationController
  def index
    @stations = Station.find(params[:q])
  end
end
