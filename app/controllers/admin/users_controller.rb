class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where(role: 'registered')
  end

  def show
    @user = User.find(params[:id])
  end

  def enable
    User.find(params[:id]).update(disabled: false)
    flash.notice = 'You have enabled a user'
    redirect_to admin_users_path
  end

  def disable
    User.find(params[:id]).update(disabled: true)
    flash.notice = 'You have disabled a user'
    redirect_to admin_users_path
  end
end
