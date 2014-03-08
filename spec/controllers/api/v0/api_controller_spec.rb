require 'spec_helper'

module Api
  module V0
    describe ApiController do
      controller(ApiController) do
        def index
          unless params[:rescue].nil?
            err = ApiController.const_get(params[:rescue].camelize)
            raise err unless err.nil?
          end

          render :json => {}
        end
      end

      context "before filters" do
        before :each do
          bypass_rescue

          # @user = create(:user)
          # @user.ensure_authentication_token!

          request.env['HTTP_HOST'] = 'airaware-api.gigabase.org'
        end

        context "request format" do
          # before :each do
          #   request.env['Authorization'] = "GIGA token='#{@user.authentication_token}'"
          # end

          it "should raise ApiController::UnsupportedMediaType if request format is not :json" do
            expect{
              get :index
            }.to raise_error(ApiController::UnsupportedMediaType)
          end
        end
      end

      context "rescue handlers" do
        before :each do
          request.env['HTTP_HOST'] = 'airaware-api.gigabase.org'
          request.env['CONTENT_TYPE'] = 'application/json'
          request.env['HTTP_ACCEPT'] = 'application/json'
          # request.env['Authorization'] = "GIGA token='#{@user.authentication_token}'"
        end
        {
          :bad_request => 400,
          :unauthorized => 401,
          :forbidden => 403,
          :not_found => 404,
          :not_acceptable => 406,
          :unsupported_media_type => 415,
          :expectation_failed => 417,
          :unprocessable_entity => 422,
          :not_implemented => 501
        }.each do |error, error_no|
          it "should work for #{error}" do

            get :index, :rescue => error.to_s

            response.status.should == error_no
          end
        end
      end
    end
  end
end
