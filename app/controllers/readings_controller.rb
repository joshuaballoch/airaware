class ReadingsController < ApplicationController
  respond_to :json, :only => [:index]
  respond_to :xml, :only => [:us_consulate]
  def index
    @location = Location.find(params[:location_id])
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

    # TO DO: add specs, use a decorator instead of to_json
    render :json => @readings.to_json
  end

  def us_consulate
    cache_key = ['us_consulate', 'v3', Time.now.strftime('%y %m %d %H'), Time.now.strftime("%M").to_i/10*10]

    ce = Rails.cache.fetch cache_key do
      ace = Curl::Easy.new("http://airpi.gigabase.org/web/rss/1/4.xml")
      ace.perform
      ace.body_str
    end

    @result = Nokogiri::XML::Document.parse(ce)
    render :xml => @result
  end
end
