class LocationsController < ApplicationController
  load_and_authorize_resource

  def new
    @location = Location.new
  end

  def show
    @location = Location.find(params[:id])
    @readings = @location.readings.ordered.limit(100)
    @last_reading = @readings.ordered.first
  end
end
