class SignUpsController < ApplicationController

  def create
    signup = SignUp.new(params[:sign_up])
    if signup.save
      flash.notice = "Thanks for signing up!"
    else
      flash.alert = signup.errors.to_a.first
    end
    redirect_to '/demo'
  end
end
