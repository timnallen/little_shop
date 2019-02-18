class Merchant::OrdersController < Merchant::BaseController
  def show
    @order = Order.find(params[:id])
    @customer = @order.user
    @order_items = @order.order_items.joins(:item)
                  .select("order_items.*,items.name as name, items.image as image")
                  .where(items: {user: current_user.id})
  end

  def update
    redirect_to merchant_order_path(Order.find(params[:id]))
  end
end
