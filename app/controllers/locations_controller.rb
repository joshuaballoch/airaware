class LocationsController < ApplicationController

  def show
    @location = Location.find_by_id(params[:id])
    @readings = @location.readings.ordered
    @last_reading = @readings.first
  end
end
