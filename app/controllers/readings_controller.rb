class ReadingsController < ApplicationController
  respond_to :json, :only => [:index]
  respond_to :xml, :only => [:us_consulate]
  def index
    @device = ReportingDevice.find(params[:reporting_device_id])

    @readings = Reading.find_by_sql(
      ["
        SELECT *
        FROM (
            SELECT
                @row := @row +1 AS rownum, reading_time, temperature, humidity, hcho, co2, tvoc, pm2p5, reporting_device_id
            FROM (
                SELECT @row :=0) r, readings
            ) ranked
        WHERE reporting_device_id = ? AND rownum % 15 = 1
        ORDER BY reading_time DESC
        LIMIT 96
      ", @device.id]
    )

    # TO DO: add specs, use a decorator instead of to_json
    render :json => @readings.to_json
  end

  def latest
    @device = ReportingDevice.find(params[:reporting_device_id])
    @reading = @device.readings.ordered.first
    render :json => @reading.to_json
  end

  def us_consulate
    if params[:city] == "shanghai"
      cache_key = ['us_consulate_shanghai', 'v1', Time.now.strftime('%y %m %d %H'), Time.now.strftime("%M").to_i/10*10]
      url = "http://airpi.gigabase.org/web/rss/1/4.xml"
    elsif params[:city] == "beijing"
      cache_key = ['us_consulate_beijing', 'v1', Time.now.strftime('%y %m %d %H'), Time.now.strftime("%M").to_i/10*10]
      url = "http://airpi.gigabase.org/web/rss/1/1.xml"
    else
      raise BadRequest
    end
    ce = Rails.cache.fetch cache_key do
      ace = Curl::Easy.new(url)
      ace.perform
      ace.body_str
    end

    @result = Nokogiri::XML::Document.parse(ce)
    render :xml => @result
  end

end
