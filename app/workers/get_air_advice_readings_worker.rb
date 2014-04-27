class GetAirAdviceReadingsWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence  { hourly.minute_of_hour(0, 15, 30, 45) }

  def perform
    ReportingDevice.where(:device_type => ReportingDeviceType::AIR_ADVICE).find_each do |device|
      service = GetAirAdviceReadingsService.new :reporting_device_id => device.id
      service.perform
    end
  end

end
