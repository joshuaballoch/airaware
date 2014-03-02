require 'spec_helper'

describe PagesController do
  context "GET HOME" do
    it "should work" do
      get :home
      response.should be_success
    end
  end
end
