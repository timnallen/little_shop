class Merchant::UsersController < Merchant::BaseController
  def show
    # @orders = Order.pending_orders(merchant)
    @orders = Order.all
  end
end
