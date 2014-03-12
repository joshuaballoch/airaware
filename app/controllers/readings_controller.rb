class ReadingsController < ApplicationController
  respond_to :json, :only => [:index]
  respond_to :xml, :only => [:us_consulate]
  def index
    @location = Location.find(params[:location_id])
    @readings = @location.readings.ordered.limit(10)
    # TO DO: add specs, use a decorator instead of to_json
    render :json => @readings.to_json
  end

  def us_consulate
    cache_key = ['us_consulate', 'v3', Time.now.strftime('%H')]

    ce = Rails.cache.fetch cache_key do
      ace = Curl::Easy.new("http://www.stateair.net/web/rss/1/4.xml")
      ace.perform
      ace.body_str
    end

    @result = Nokogiri::XML::Document.parse(ce)
    render :xml => @result
  end
end
