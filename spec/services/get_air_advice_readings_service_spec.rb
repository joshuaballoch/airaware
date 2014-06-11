require 'spec_helper'

describe GetAirAdviceReadingsService do
  context "initialize" do
    it "should raise InvalidParams unless reporting_device_id is passed" do
      expect {
        GetAirAdviceReadingsService.new report_id: "asdf"
      }.to raise_error(GetAirAdviceReadingsService::InvalidParams)
    end
  end

  context "url methods" do
    let (:device) {
      create :reporting_device
    }
    let (:service) {
      GetAirAdviceReadingsService.new reporting_device_id: device.id
    }
    it "#base_url should work" do
      service.base_url.should == "http://50.56.204.225:11011/readings/#{device.identifier}"
    end
    it "#url should add offset and limit to base_url" do
      service.offset = 12
      service.limit = 5
      service.url.should == "http://50.56.204.225:11011/readings/#{device.identifier}?offset=#{12}&quantity=#{5}"
    end
  end

  context "fetch_readings" do
    before :all do
      @device = create :reporting_device
      @curl = Object.new
    end
    before :each do
      @service = GetAirAdviceReadingsService.new reporting_device_id: @device.id
      @sample_data = "[{\"Timestamp\":\"2014-03-31 11:18:14\",\"Part\":5.69,\"Temp\":74.91,\"Humi\":40.75,\"CO\":0.27,\"CO2\":475.48,\"Gas\":7.78},{\"Timestamp\":\"2014-03-31 11:17:14\",\"Part\":6.44,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0,\"CO2\":475.48,\"Gas\":7.6},{\"Timestamp\":\"2014-03-31 11:16:14\",\"Part\":6.44,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":454.84,\"Gas\":7.22},{\"Timestamp\":\"2014-03-31 11:15:14\",\"Part\":5.69,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":444.52,\"Gas\":6.82},{\"Timestamp\":\"2014-03-31 11:14:14\",\"Part\":6.44,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":443.68,\"Gas\":6.69},{\"Timestamp\":\"2014-03-31 11:13:14\",\"Part\":6.44,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":444.52,\"Gas\":6.75},{\"Timestamp\":\"2014-03-31 11:12:14\",\"Part\":5.69,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":443.68,\"Gas\":6.74},{\"Timestamp\":\"2014-03-31 11:11:14\",\"Part\":4.94,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":443.68,\"Gas\":6.76},{\"Timestamp\":\"2014-03-31 11:10:14\",\"Part\":7.19,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":444.52,\"Gas\":6.82},{\"Timestamp\":\"2014-03-31 11:09:14\",\"Part\":5.69,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":443.68,\"Gas\":6.78}]"
      @curl_results = [@sample_data, "[]"]
    end
    it "should perform a curl to url" do
      mock(Curl::Easy).new(@service.url) { @curl }
      stub(@curl).perform { true }
      stub(@curl).body_str { @curl_results.shift }
      @service.fetch_readings
    end
    it "should load results into readings_received" do
      stub(Curl::Easy).new(@service.url) { @curl }
      stub(@curl).perform { true }
      stub(@curl).body_str { @curl_results.shift }
      @service.readings_received.count.should == 0
      @service.fetch_readings
      @service.readings_received.should == JSON.parse(@sample_data)
    end
    context "repeat readings" do
      before :each do
        @service.limit = 3
        curl_results = [@sample_data, "[{\"Timestamp\":\"2014-04-31 11:18:14\",\"Part\":5.69,\"Temp\":74.91,\"Humi\":40.75,\"CO\":0.27,\"CO2\":475.48,\"Gas\":7.78}]", @sample_data, "[]"]
        stub(Curl::Easy).new() { @curl }
        stub(@curl).body_str { curl_results.shift }
      end
      it "should fetch a second time if fewer than limit were returned" do
        mock(@curl).perform(){ true }.twice()
        @service.fetch_readings
      end
      it "should not fetch a second time one reading included is already in the reporting device's readings" do
        @device.readings.create :reading_time => "2014-03-31 11:17:14", :pm2p5 => 6.44, :temperature => 74.91, :humidity => 40.22, :co2 => 475.48, :co => 0, :tvoc => 7.6
        @service.instance_variable_set(:@last_reading, @device.readings.ordered.first)
        mock(@curl).perform(){ true }.once()
        @service.fetch_readings
      end
    end
  end

  context "prep & clean readings" do
    before :each do
      @device = create :reporting_device
      @service = GetAirAdviceReadingsService.new reporting_device_id: @device.id
      @sample_data = "[{\"Timestamp\":\"2014-03-31 11:18:14\",\"Part\":5.69,\"Temp\":74.91,\"Humi\":40.75,\"CO\":0.27,\"CO2\":475.48,\"Gas\":7.78},{\"Timestamp\":\"2014-03-31 11:17:14\",\"Part\":6.44,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0,\"CO2\":475.48,\"Gas\":7.6},{\"Timestamp\":\"2014-03-31 11:16:14\",\"Part\":6.44,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":454.84,\"Gas\":7.22},{\"Timestamp\":\"2014-03-31 11:15:14\",\"Part\":5.69,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":444.52,\"Gas\":6.82},{\"Timestamp\":\"2014-03-31 11:14:14\",\"Part\":6.44,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":443.68,\"Gas\":6.69},{\"Timestamp\":\"2014-03-31 11:13:14\",\"Part\":6.44,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":444.52,\"Gas\":6.75},{\"Timestamp\":\"2014-03-31 11:12:14\",\"Part\":5.69,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":443.68,\"Gas\":6.74},{\"Timestamp\":\"2014-03-31 11:11:14\",\"Part\":4.94,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":443.68,\"Gas\":6.76},{\"Timestamp\":\"2014-03-31 11:10:14\",\"Part\":7.19,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":444.52,\"Gas\":6.82},{\"Timestamp\":\"2014-03-31 11:09:14\",\"Part\":5.69,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":443.68,\"Gas\":6.78}]"
      @service.instance_variable_set(:@readings_received, JSON.parse(@sample_data))
    end
    it "prep_readings should call clean_readings" do
      mock(@service).clean_readings
      @service.prep_readings
    end
    it "prep_readings should load records to save into @to_save" do
      @service.prep_readings
      @service.instance_variable_get(:@to_save).count.should == @service.readings_received.count
    end
    it "clean_readings should get rid of readings with times older than those already saved" do
      @service.instance_variable_get(:@readings_received).count.should == JSON.parse(@sample_data).count
      @device.readings.create :reading_time => "2014-03-31 11:17:14", :pm2p5 => 6.44, :temperature => 74.91, :humidity => 40.22, :co2 => 475.48, :co => 0, :tvoc => 7.6
      @service.instance_variable_set(:@last_reading, @device.readings.ordered.first)
      @service.clean_readings
      @service.instance_variable_get(:@readings_received).count.should < JSON.parse(@sample_data).count
    end
  end

  context "perform" do
    before :all do
      @device = create :reporting_device
      @curl = Object.new
    end
    before :each do
      @service = GetAirAdviceReadingsService.new reporting_device_id: @device.id
      @sample_data = "[{\"Timestamp\":\"2014-03-31 11:18:14\",\"Part\":5.69,\"Temp\":74.91,\"Humi\":40.75,\"CO\":0.27,\"CO2\":475.48,\"Gas\":7.78},{\"Timestamp\":\"2014-03-31 11:17:14\",\"Part\":6.44,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0,\"CO2\":475.48,\"Gas\":7.6},{\"Timestamp\":\"2014-03-31 11:16:14\",\"Part\":6.44,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":454.84,\"Gas\":7.22},{\"Timestamp\":\"2014-03-31 11:15:14\",\"Part\":5.69,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":444.52,\"Gas\":6.82},{\"Timestamp\":\"2014-03-31 11:14:14\",\"Part\":6.44,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":443.68,\"Gas\":6.69},{\"Timestamp\":\"2014-03-31 11:13:14\",\"Part\":6.44,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":444.52,\"Gas\":6.75},{\"Timestamp\":\"2014-03-31 11:12:14\",\"Part\":5.69,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":443.68,\"Gas\":6.74},{\"Timestamp\":\"2014-03-31 11:11:14\",\"Part\":4.94,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":443.68,\"Gas\":6.76},{\"Timestamp\":\"2014-03-31 11:10:14\",\"Part\":7.19,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":444.52,\"Gas\":6.82},{\"Timestamp\":\"2014-03-31 11:09:14\",\"Part\":5.69,\"Temp\":74.91,\"Humi\":40.22,\"CO\":0.27,\"CO2\":443.68,\"Gas\":6.78}]"
      @curl_results = [@sample_data, "[]"]
      stub(Curl::Easy).new(@service.url) { @curl }
      stub(@curl).perform { true }
      stub(@curl).body_str { @curl_results.shift }
    end
    it "should fetch readings" do
      mock(@service).fetch_readings
      @service.instance_variable_set(:@to_save, [])
      @service.perform
    end
    it "should prep_readings" do
      mock(@service).prep_readings
      @service.instance_variable_set(:@to_save, [])
      @service.perform
    end
    it "should work" do
      expect {
        @service.perform
      }.to change(Reading, :count).by(10)
      @device.readings.count.should == 10
    end
    it "should load the data into the correct fields" do
      @service.perform
      ref_reading = JSON.parse("{\"Timestamp\":\"2014-03-31 11:18:14\",\"Part\":5.69,\"Temp\":74.91,\"Humi\":40.75,\"CO\":0.27,\"CO2\":475.48,\"Gas\":7.78}")
      reading = @device.readings.ordered.first
      reading.temperature.should == ref_reading["Temp"]
      reading.humidity.should == ref_reading["Humi"]
      # TO DO: implement this test of airadvice monitors include hcho
      # reading.hcho
      reading.co2.should == ref_reading["CO2"]
      reading.co.should == ref_reading["CO"]
      reading.tvoc.should == ref_reading["Gas"]
      reading.pm2p5.should == ref_reading["Part"]
    end
  end
end
