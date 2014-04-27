require 'spec_helper'

describe GetAirAdviceReadingsWorker do
  before do
    2.times do
      create :reporting_device, :device_type => ReportingDeviceType::AIR_ADVICE
    end
    create :reporting_device, :device_type => ReportingDeviceType::FLUKE
  end
  it "should initialize and perform a GetAirAdviceReadingsService for each AIR_ADVICE reporting device" do
    service = Object.new
    ReportingDevice.air_advice.each do |rd|
      mock(GetAirAdviceReadingsService).new({:reporting_device_id => rd.id}) { service }
    end
    mock(service).perform.twice()
    worker = GetAirAdviceReadingsWorker.new
    worker.perform
  end
end
