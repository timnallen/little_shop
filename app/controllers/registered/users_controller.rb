class Registered::UsersController < Registered::BaseController
  def show
    @user = current_user
  end
end
