class ReadingsController < ApplicationController

  def index
    @location = Location.find(params[:location_id])
    @readings = @location.readings.ordered
    # TO DO: add specs, use a decorator instead of to_json
    render :json => @readings.to_json
  end
end
