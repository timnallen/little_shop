class Merchant::OrdersController < Merchant::BaseController
  def show
    @order = Order.find(params[:id])
    @customer = @order.user
    @items = Item.joins(:orders)
                  .where(user: current_user.id)
                  .group(:id)

    @items_and_quantities = Hash.new

    @items.each do |item|
      @items_and_quantities[item] = item.order_items.where(order_id: @order.id).sum(:quantity)
    end

  end
end
