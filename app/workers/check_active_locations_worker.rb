class CheckActiveLocationsWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence  { hourly.minute_of_hour(0, 30) }

  def perform
    Location.where(:active => true).find_each do |location|
      stale = location.reporting_devices.find_all{ |r| r.stale? }
      if stale.count > 0
      	# Send an email!
      	# TO DO: check if this needs to go async
        location.admin_watchers.each do |user|
          MonitorMailer.stale_location(user.email, location.id, stale).deliver
        end
        # Also send it to webmaster
        MonitorMailer.stale_location("webmaster.josh.balloch@gmail.com", location.id, stale).deliver
      end
    end
  end

end
