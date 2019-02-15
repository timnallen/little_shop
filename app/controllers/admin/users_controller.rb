class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where(role: 'registered')
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "User profile has been updated"
      redirect_to admin_user_path(@user)
    else
      errors = @user.errors.details
      if errors.has_key?(:email) && errors[:email].first[:error] == :taken
        flash[:danger] = "That email is already registered."
        @user.email = nil
        render :'users/edit'
      end
    end

  end


  def enable
    User.find(params[:id]).update(disabled: false)
    flash[:primary] = 'You have enabled a user'
    redirect_to admin_users_path
  end

  def disable
    User.find(params[:id]).update(disabled: true)
    flash[:primary] = 'You have disabled a user'
    redirect_to admin_users_path
  end

  private

  def user_params
    strong_params = params.require(:user).permit(:name, :address, :city, :state, :zipcode, :email, :password, :password_confirmation)
    strong_params.delete(:password) if strong_params[:password] == ""
    strong_params.delete(:password_confirmation) if strong_params[:password_confirmation] == ""
    strong_params
  end
end
