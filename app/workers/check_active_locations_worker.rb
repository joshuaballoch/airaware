class CheckActiveLocationsWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence  { hourly.minute_of_hour(0, 30) }

  def perform
    Location.where(:active => true).find_each do |location|
      stale = location.reporting_devices.find_all{ |r| r.readings.ordered.first.reading_time <= 1.hour.ago }
      if stale.count > 0
      	# Send an email!
      	# TO DO: check if this needs to go async
      	MonitorMailer.stale_location(location.id, stale).deliver
      end
    end
  end

end
