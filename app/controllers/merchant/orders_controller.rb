class Merchant::OrdersController < Merchant::BaseController
  def show
    @order = Order.find(params[:id])
    @customer = @order.user
    @order_items = @order.order_items.joins(:item)
                  .select("order_items.*,items.name as name, items.image as image")
                  .where(items: {user: current_user.id})
  end

  def update
    order_item = OrderItem.find(params[:order_item])
    order_item.update(fulfilled: true)
    item = Item.find(order_item.item_id)
    new_quantity = item.quantity - order_item.quantity
    item.update(quantity: new_quantity)
    flash[:success] = "You have fulfilled #{item.name} from order ##{order_item.order_id}"
    redirect_to merchant_order_path(Order.find(params[:id]))
  end
end
