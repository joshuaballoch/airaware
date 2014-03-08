module Api
  module V0
    class ReadingsController < ApiController

      def create
        # Ensure that the request has data
        raise BadRequest unless params[:reading] && !params[:reading].empty?
        raise BadRequest unless params[:device_identifier]

        @reporting_device = ReportingDevice.where(:identifier => params[:device_identifier]).first
        # TO DO: yield an error unless reporting device has previously been set up.
        #   for now, just create the reporting device.
        unless @reporting_device
          location = Location.first
          @reporting_device = ReportingDevice.new :identifier => params[:device_identifier], :location_id => location.id
          @reporting_device.save!
        end

        @reading = @reporting_device.readings.build params[:reading]
        if @reading.save
          render :json => {:success => true}, :status => 200
        else
          render :json => {:success => false, :errors => @reading.errors.to_a.first }, :status => 422
        end
      end

    end
  end
end