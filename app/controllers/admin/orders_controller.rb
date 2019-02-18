class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.where(user_id: params[:user_id])
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.cancel
    flash[:danger] = "Order ##{@order.id} has been cancelled."
    redirect_to admin_user_path(@order.user_id)
  end
end
