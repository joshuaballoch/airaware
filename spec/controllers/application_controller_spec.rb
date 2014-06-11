require 'spec_helper'

describe ApplicationController do
  controller do
    # before_filter :initialize_account

    def index
      unless params[:rescue].nil?
        raise CanCan::AccessDenied if params[:rescue] == "CanCan::AccessDenied"
        err = ApplicationController.const_get(params[:rescue].camelize)
        raise err unless err.nil?
      end



      render :text => "Success"
    end
  end

  context "Errors" do
    context "CanCan::AccessDenied" do
      it "should redirect to new_user_session_path if not logged in" do
        get :index, :rescue => "CanCan::AccessDenied"
        response.should redirect_to(new_user_session_path)
      end
      it "should redirect to root path if logged in" do
        Globalize.with_locale :"en-US" do
          user = create :user
          sign_in user
          get :index, :rescue => "CanCan::AccessDenied"
          response.should redirect_to(root_path)
          flash.alert.should == "You to not have permission to access http://test.host/anonymous?rescue=CanCan%3A%3AAccessDenied."
        end
      end
      it "should should return 403 with json format" do
        get :index, :format => :json, :rescue => "CanCan::AccessDenied"
        response.status.should == 403
      end
      it "should should return 403 with xhr request" do
        xhr :get, :index, :rescue => "CanCan::AccessDenied"
        response.status.should == 403
      end
    end
    {
      :bad_request => 400,
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
