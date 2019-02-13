class Registered::UsersController < Registered::BaseController
  def show
  end

  def edit
    @user = current_user
  end
end
