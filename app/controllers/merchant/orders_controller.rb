class Merchant::OrdersController < Merchant::BaseController
  def show
    @order = Order.find(params[:id])
    @customer = @order.user
  end

  def update
    order_item = OrderItem.find(params[:ordered_item])
    order_item.update(fulfilled: true)
    item = Item.find(order_item.item_id)
    new_quantity = item.quantity - order_item.quantity
    item.update(quantity: new_quantity)
    flash[:success] = "You have fulfilled #{item.name} from order ##{order_item.order_id}"
    order = Order.find(params[:id])
    if order.order_items.where(fulfilled: false).count == 0
      order.update(status: 'completed')
    end
    redirect_to merchant_order_path(order)
  end
end
