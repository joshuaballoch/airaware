class GetAirAdviceReadingsWorker
  include Sidekiq::Worker

  def perform(id)
    service = GetAirAdviceReadingsService.new :reporting_device_id => id
    service.perform
  end

end
