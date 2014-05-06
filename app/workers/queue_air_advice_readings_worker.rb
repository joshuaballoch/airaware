class QueueAirAdviceReadingsWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence  { hourly.minute_of_hour(0, 15, 30, 45) }

  def perform
    ReportingDevice.where(:device_type => ReportingDeviceType::AIR_ADVICE).find_each do |device|
      GetAirAdviceReadingsWorker.perform_async(device.id)
    end
  end

end
