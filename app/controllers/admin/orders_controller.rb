class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.where(user_id: params[:user_id])
  end

  def show
  end
end
