class ReadingsController < ApplicationController

  def index
    @location = Location.find(params[:location_id])
    if @location.readings.ordered.recent_only.count < 10
      @readings = @location.readings.ordered.limit(10)
    else
      @readings = @location.readings.ordered.recent_only
    end
    # TO DO: add specs, use a decorator instead of to_json
    render :json => @readings.to_json
  end
end
