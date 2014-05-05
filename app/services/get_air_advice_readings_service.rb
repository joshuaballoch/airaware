## Get Air Advice Readings Service
#
#  Function
#    1. To check for new air advice readings via air advice API.

#  Usage
#     1. Initialize the service
#
#          E.g. @service = Services::GetAirAdviceReadings.new reporting_device_id: 1
#
#     2. Perform the service
#
#          E.g. @service.perform
#
#     3. If successful, perform will return true. The returned readings from airadvice
#        will be already be saved into the database
#
#     4. If unsuccessful, perform will return false
#

class GetAirAdviceReadingsService
  attr_accessor :readings_received, :limit, :offset

  class Error < StandardError; end

  class InvalidParams < Error

  end

  def initialize(params)
    raise InvalidParams unless params[:reporting_device_id]
    @device = ReportingDevice.find(params[:reporting_device_id])

    @last_reading = @device.readings.ordered.first || Reading.new({reading_time: DateTime.new(2014, 04, 29)})
    @identifier = @device.identifier

    # Initialize Offset and Limit
    @limit = 20
    @offset = 0

    # Initialize a readings array
    @readings_received = []
  end

  def perform
    fetch_readings
    prep_readings
    if valid?
      persist!
      true
    else
      false
    end
  end

  def errors
    @errors.uniq || []
  end

  def valid?
    @errors = []
    @to_save.select {|x| !x.valid? }.each do |invalid|
      @errors << invalid.errors.to_a
    end
    return @errors.count > 0 ? false : true
  end

  def base_url
    return "http://50.56.204.225:11011/readings/#{@device.identifier}"
  end

  def url
    "#{base_url}?offset=#{@offset}&quantity=#{@limit}"
  end

  def fetch_readings
    fetch = Curl::Easy.new(url)
    fetch.perform
    raw_received = JSON.parse(fetch.body_str)
    @readings_received.concat raw_received
    unless raw_received.count < @limit || DateTime.from_str(@readings_received.last["Timestamp"]) <= @last_reading.reading_time
      #then we've not fetched enough. increase the offset and fetch again
      @offset += @limit
      fetch_readings
    end
  end

  def clean_readings
    @readings_received = @readings_received.select {|x| DateTime.from_str(x["Timestamp"]) > @last_reading.reading_time}
  end

  def prep_readings
    clean_readings
    @to_save = []
    @readings_received.each do |reading|
      r = @device.readings.build :reading_time => DateTime.from_str(reading["Timestamp"]),
                                 :pm2p5        => reading["Part"],
                                 :temperature  => (reading["Temp"].to_f-32)*(5/9),
                                 :humidity     => reading["Humi"],
                                 :co2          => reading["CO2"],
                                 :co           => reading["CO"],
                                 :tvoc         => reading["Gas"].to_f*0.001
      @to_save << r
    end
  end

  private
    def persist!
      @to_save.each do |r|
        r.save
      end
    end

end
