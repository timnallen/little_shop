class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where(role: 'registered')
  end

  def show
    @user = User.find(params[:id])
    redirect_to admin_merchant_path(@user) if @user.role == 'merchant'
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
      flash[:danger] = "There are problems with the provided information."
      render :'users/edit'
    end
  end

  def enable
    @user = User.find(params[:id])
    @user.update(disabled: false)
    flash[:primary] = 'You have enabled a user'
    redirect_helper
  end

  def disable
    @user = User.find(params[:id])
    @user.update(disabled: true)
    flash[:primary] = 'You have disabled a user'
    redirect_helper
  end

  def upgrade
    @user = User.find(params[:id])
    @user.update(role: 'merchant')
    flash[:primary] = 'You have upgraded a user'
    redirect_to admin_merchant_path(@user)
  end

  private

  def redirect_helper
    redirect_to admin_users_path if @user.role == 'registered'
    redirect_to merchants_path if @user.role == 'merchant'
  end

  def user_params
    strong_params = params.require(:user).permit(:name, :address, :city, :state, :zipcode, :email, :password, :password_confirmation)
    strong_params.delete(:password) if strong_params[:password] == ""
    strong_params.delete(:password_confirmation) if strong_params[:password_confirmation] == ""
    strong_params
  end
end
