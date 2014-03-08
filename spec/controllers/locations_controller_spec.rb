require 'spec_helper'

describe LocationsController do
  context "get #show" do
    before do
      @location = create :location
    end
    it "should work" do
      get :show, :id => @location.id
      response.should be_success
      assigns[:location].should == @location
    end
  end
end
