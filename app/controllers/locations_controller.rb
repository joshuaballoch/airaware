class LocationsController < ApplicationController

  def show
    id = params[:id] || 1
    @location = Location.find_by_id(id)
    @readings = @location.readings.find_by_sql(
      %{
        SELECT *
        FROM (
            SELECT
                @row := @row +1 AS rownum, reading_time, temperature, humidity, hcho, co2, tvoc, pm2p5, reporting_device_id
            FROM (
                SELECT @row :=0) r, readings
            ) ranked
        WHERE rownum % 20 = 1
        ORDER BY reading_time DESC
        LIMIT 60
      }
    )
    @last_reading = @location.readings.last
  end
end
