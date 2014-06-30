module Api
  module V0
    class ReadingsController < ApiController

      def create
        # Ensure that the request has data
        raise BadRequest unless params[:reading] && !params[:reading].empty?
        raise BadRequest unless params[:device_identifier]

        @reporting_device = ReportingDevice.where(:identifier => params[:device_identifier]).first

        raise NotFound unless @reporting_device

        @reading = @reporting_device.readings.build params[:reading]
        if @reading.save
          render :json => {:success => true}, :status => 200
        else
          render :json => {:success => false, :errors => @reading.errors.to_a.first }, :status => 422
        end
      end

      def index
        # TO DO: authorize that the caller has access?
        # authorize! somehow? or an API key?

        @reporting_device = ReportingDevice.find(params[:reporting_device_id])

        # Consider implementing from/to
        # if params[:from] || (params[:from] && params[:to])
        limit = params[:limit] || 60 # get ~ one hours worth if no limit
        offset = params[:offset] || 0 # by default, fetch latest
        
        @readings = @reporting_device.readings.offset(offset).limit(limit)

        render :json => {:id => @reporting_device.id, :label => @reporting_device.label, :identifier => @reporting_device.identifier, :location => {:id => @reporting_device.location.try(:id), :name => @reporting_device.location.try(:name)}, :readings => @readings.to_json}
            
      end

    end
  end
end
