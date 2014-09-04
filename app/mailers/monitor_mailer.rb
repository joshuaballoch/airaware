class MonitorMailer < ActionMailer::Base
  default :from => 'no-reply-airaware@gigabase.org'

  def stale_location(location_id, reporting_device_ids)
    @location = Location.find(location_id)
    @reporting_devices = ReportingDevice.where(:id => reporting_device_ids)

    headers = {
      :to => "webmaster.josh.balloch@gmail.com",
      :subject => "[AirAware Urgent] Loc #{@location.name} (id: #{@location.id}) Stale Readings Alert ",
    }

    mail headers do |format|
      format.html(:content_transfer_encoding => 'base64') {
        Base64.encode64(render)
      }
    end
  end

protected
  def email_user(email)
    User.where(:email => email).first || User.new(:username => email.split('@').first, :email => email)
  end
end
