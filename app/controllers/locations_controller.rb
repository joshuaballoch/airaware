class LocationsController < ApplicationController
  layout 'application_public'
  load_and_authorize_resource

  def new
    @location = Location.new
  end

  def show
    @location = Location.includes(:reporting_devices).find(params[:id])
    @reporting_devices = @location.reporting_devices
  end
end
