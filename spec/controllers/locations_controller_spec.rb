require 'spec_helper'

describe LocationsController do
  include Devise::TestHelpers
  before :all do
    @user = create :user
  end
  before :each do
    sign_in @user
  end
  context "get #new" do
    it "should work" do
      get :new
      response.should be_success
    end
    it "should authorize :new, Location" do
      new_location = Location.new
      stub(Location).new { new_location }
      mock(controller).authorize!(:new, new_location)
      get :new
    end
  end
  context "get #show" do
    before do
      @location = create :location
    end
    it "should work" do
      get :show, :id => @location.id
      response.should be_success
      assigns[:location].should == @location
    end
    it "should authorize :show, @location" do
      mock(controller).authorize!(:show, @location)
      get :show, :id => @location.id
    end
  end
end
