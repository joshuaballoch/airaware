class LocationsController < ApplicationController
  layout 'application_public'
  load_and_authorize_resource

  def new
    @location = Location.new
  end

  def show
    @location = Location.find(params[:id])
  end
end
