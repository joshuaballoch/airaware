module Api
  module V0
    class ReadingsController < ApiController

      def create
        # Ensure that the request has data
        raise BadRequest unless params[:reading] && !params[:reading].empty?
        raise BadRequest unless params[:device_identifier]

        @reporting_device = ReportingDevice.where(:identifier => params[:device_identifier]).first

        # For fluke, create a new device!
        unless @reporting_device
          @reporting_device = ReportingDevice.new
          @reporting_device.identifier = params[:device_identifier]
          @reporting_device.device_type = ReportingDeviceType::FLUKE
          @reporting_device.location = Location.find(1)
          @reporting_device.label = params[:device_identifier]
          @reporting_device.save!
        end
        
        raise NotFound unless @reporting_device

        @reading = @reporting_device.readings.build :reading_time => params[:reading][:reading_time],
                     :pm2p5        => @reporting_device.pm2p5_calibration ? @reporting_device.pm2p5_calibration.adjust(params[:reading][:pm2p5]) : params[:reading][:pm2p5],
                     :temperature  => params[:reading][:temperature],
                     :humidity     => params[:reading][:humidity],
                     :co2          => @reporting_device.co2_calibration ? @reporting_device.co2_calibration.adjust(params[:reading][:co2]) : params[:reading][:co2],
                     :co           => params[:reading][:co],
                     :tvoc         => @reporting_device.tvoc_calibration ? @reporting_device.tvoc_calibration.adjust(params[:reading][:tvoc]) : params[:reading][:tvoc]

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

        # TO DO: set a max bound for limit?
        
        @readings = @reporting_device.readings.offset(offset).limit(limit)

        render :json => {:id => @reporting_device.id, :label => @reporting_device.label, :identifier => @reporting_device.identifier, :location => {:id => @reporting_device.location.try(:id), :name => @reporting_device.location.try(:name)}, :readings => @readings.to_json}
            
      end

    end
  end
end
