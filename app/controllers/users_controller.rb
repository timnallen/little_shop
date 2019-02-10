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
      errors = @user.errors.details
      if errors.has_key?(:email) && errors[:email].first[:error] == :taken
        flash.alert = 'That email is already registered.'
      else
        flash.alert = 'The information you entered was invalid.'
      end
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zipcode, :email, :password, :password_confirmation)
  end
end
