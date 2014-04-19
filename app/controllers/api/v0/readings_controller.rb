module Api
  module V0
    class ReadingsController < ApiController

      def create
        # Ensure that the request has data
        raise BadRequest unless params[:reading] && !params[:reading].empty?
        raise BadRequest unless params[:device_identifier]

        @reporting_device = ReportingDevice.where(:identifier => params[:device_identifier]).first

        raise NotFound unless @reporting_device

        # FORMER IMPLEMENTATION: this used to allow test API to initialize a new reporting device if it wasn't ther.
        # unless @reporting_device
        #   location = Location.first
        #   @reporting_device = ReportingDevice.new :location_id => location.id
        #   @reporting_device.identifier = params[:device_identifier]
        #   @reporting_device.save!
        # end

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
