class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.where(user_id: params[:user_id])
    render '/orders/index'
  end

  def show
    @order = Order.find(params[:id])
    render '/orders/show'
  end

  def update
    if params[:ordered_item]
      order = Order.find(params[:id])
      order_item = OrderItem.find(params[:ordered_item])
      order_item.update(fulfilled: true)
      item = Item.find(order_item.item_id)
      new_quantity = item.quantity - order_item.quantity
      item.update(quantity: new_quantity)
      flash[:success] = "You have fulfilled #{item.name} from order ##{order_item.order_id}"
      if order.order_items.where(fulfilled: false).count == 0
        order.update(status: 'completed')
      end
      redirect_to admin_order_path(order)
    else
      @order = Order.find(params[:id])
      @order.cancel
      flash[:danger] = "Order ##{@order.id} has been cancelled."
      redirect_to admin_user_path(@order.user_id)
    end
  end
end
