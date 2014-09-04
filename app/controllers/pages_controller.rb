class PagesController < ApplicationController
  layout 'application_public'
  def demo
    @location = Location.includes(:reporting_devices).find(7)
    @reporting_devices = @location.reporting_devices
  end

  def home
    if current_user && current_user.locations.first
      redirect_to location_path(:id => current_user.locations.first.id)
      #@locations = current_user.locations
    end
  end
end
