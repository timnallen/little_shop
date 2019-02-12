class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash.notice = "You are now logged in"
      redirect_to profile_path if current_user.registered?
      redirect_to dashboard_path if current_user.merchant?
      redirect_to root_path if current_user.admin?
    end
  end

  def destroy
    redirect_to root_path
  end
end
