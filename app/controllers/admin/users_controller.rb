class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where(role: 'registered')
  end

  def show
    # @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(disabled: params[:disabled])
    flash[:primary] = 'You have enabled a user' if params[:disabled] == "false"
    flash[:primary] = 'You have disabled a user' if params[:disabled] == "true"
    redirect_to admin_users_path
  end
end
