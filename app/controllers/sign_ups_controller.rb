class SignUpsController < ApplicationController

  def create
    signup = SignUp.new(params[:sign_up])
    if signup.save
      flash.notice = "Thanks for signing up!"
      redirect_to "https://www.surveymonkey.com/s/W8VTBYZ"
    else
      flash.alert = signup.errors.to_a.first
      redirect_to '/demo'
    end

  end
end
