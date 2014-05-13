class PagesController < ApplicationController

  def demo
    if Rails.env.development?
      @location = Location.find(1)
    else
      @location = Location.find(7)
    end
    @readings = @location.readings.ordered
    # @readings = @location.readings.find_by_sql(
    #   %{
    #     SELECT *
    #     FROM (
    #         SELECT
    #             @row := @row +1 AS rownum, reading_time, temperature, humidity, hcho, co2, tvoc, pm2p5, reporting_device_id
    #         FROM (
    #             SELECT @row :=0) r, readings
    #         ) ranked
    #     WHERE rownum % 20 = 1
    #     ORDER BY reading_time DESC
    #     LIMIT 60
    #   }
    # )
    @last_reading = @readings.first
  end

  def home
    if current_user && current_user.locations.first
      redirect_to location_path(:id => current_user.locations.first.id)
      #@locations = current_user.locations
    end
  end
end
