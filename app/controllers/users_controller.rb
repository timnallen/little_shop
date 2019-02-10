class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.notice = 'You are now registered and logged in!'
      redirect_to profile_path
    else
      flash.alert = 'You are missing required fields.'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zipcode, :email, :password, :password_confirmation)
  end
end
