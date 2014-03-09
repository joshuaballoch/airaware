class LocationsController < ApplicationController

  def show
    @location = Location.find_by_id(params[:id])
  end
end
