class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where(role: 'registered')
  end

  def show
    @user = User.find(params[:id])
  end
end
