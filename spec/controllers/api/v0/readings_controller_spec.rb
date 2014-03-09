require 'spec_helper'

module Api
  module V0
    describe ReadingsController do
      context "POST :create" do
        before :all do
          @location = create :location
          @reporting_device = create :reporting_device, :location => @location
          @data = attributes_for :reading, :reporting_device => nil
          @data.delete(:reporting_device)
        end
        before :each do
          request.env['HTTP_HOST'] = 'airaware.gigabase.org'
          request.env['CONTENT_TYPE'] = 'application/json'
          request.env['HTTP_ACCEPT'] = 'application/json'
        end

        it "should work" do
          post :create, :reading => @data, :device_identifier => @reporting_device.identifier, :format => :json

          response.should be_ok
          data = JSON.load(response.body)
          data['success'].should be_true
        end

        it "should require data be under :reading" do
          bypass_rescue
          expect {
            post :create, :device_identifier => @reporting_device.identifier, :format => :json
          }.to raise_error(ApiController::BadRequest)
        end
        it "should require a device_identifier" do
          bypass_rescue
          expect {
            post :create, :reading => @data, :format => :json
          }.to raise_error(ApiController::BadRequest)
        end

        it "should return errors in response" do
          send_data = @data.merge({:reading_time => "blah"})
          post :create, :reading => send_data, :device_identifier => @reporting_device.identifier, :format => :json
          response.should_not be_ok
          data = JSON.load(response.body)
          data['errors'].should_not be_nil
        end
      end
    end
  end
end
