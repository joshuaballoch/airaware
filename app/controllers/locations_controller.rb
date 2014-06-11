class LocationsController < ApplicationController
  layout 'application_public'
  load_and_authorize_resource

  def new
    @location = Location.new
  end

  def show
    @location = Location.find(params[:id])
    # @readings = @location.readings.ordered.limit(1440)
    @readings = @location.readings.ordered.find_by_sql(
      ["
        SELECT *
        FROM (
            SELECT
                @row := @row +1 AS rownum, reading_time, temperature, humidity, hcho, co2, tvoc, pm2p5, reporting_device_id
            FROM (
                SELECT @row :=0) r, readings
            ) ranked
        WHERE reporting_device_id = ? AND rownum % 20 = 1
        ORDER BY reading_time DESC
        LIMIT 72
      ", @location.reporting_devices.first.id]
    )

    @last_reading = @location.readings.ordered.first
  end
end
