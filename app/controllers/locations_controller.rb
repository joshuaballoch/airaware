class LocationsController < ApplicationController
  load_and_authorize_resource

  def new
    @location = Location.new
  end

  def show
  end
end
