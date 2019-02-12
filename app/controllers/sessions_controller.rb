class SessionsController < ApplicationController
  def new
    if current_user && current_user.registered?
      flash.notice = "You are already logged in"
      redirect_to profile_path
    elsif current_user && current_user.merchant?
      flash.notice = "You are already logged in"
      redirect_to dashboard_path
    elsif current_user && current_user.admin?
      flash.notice = "You are already logged in"
      redirect_to root_path
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash.notice = "You are now logged in"
      redirect_to profile_path if current_user.registered?
      redirect_to dashboard_path if current_user.merchant?
      redirect_to root_path if current_user.admin?
    else
      flash.alert = "Invalid email and/or password"
      render :new
    end
  end
end
