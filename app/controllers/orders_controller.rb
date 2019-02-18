class OrdersController < ApplicationController
  before_action :require_registered

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    user = User.find(current_user.id)
    order = user.orders.create
    @cart.contents.each do |item_id, quantity|
      item = Item.find(item_id)
      order.order_items.create(item: item, unit_price: item.price, quantity: quantity)
    end
    @cart.contents.clear
    flash[:success] = "Your order was created!"
    redirect_to profile_orders_path
  end
end
