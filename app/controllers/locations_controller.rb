class LocationsController < ApplicationController

  def show
    id = params[:id] || 1
    @location = Location.find_by_id(id)
    @readings = @location.readings.ordered.limit(10)
    @last_reading = @readings.first
  end
end
