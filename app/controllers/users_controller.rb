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
        @user.email = nil
      else
        flash.alert = 'The information you entered was invalid.'
      end
      render :new
    end
  end

    def update
      @user = current_user
      if @user.update(user_params)
        flash.notice = "Your profile has been updated"
        redirect_to profile_path
      else
        errors = @user.errors.details
        if errors.has_key?(:email) && errors[:email].first[:error] == :taken
          flash.alert = 'That email is already registered.'
          @user.email = nil
          render :'registered/users/edit'
        end
      end
    end



  private

  def user_params
    strong_params = params.require(:user).permit(:name, :address, :city, :state, :zipcode, :email, :password, :password_confirmation)
    strong_params.delete(:password) if strong_params[:password] == ""
    strong_params.delete(:password_confirmation) if strong_params[:password_confirmation] == ""
    strong_params
  end
end
