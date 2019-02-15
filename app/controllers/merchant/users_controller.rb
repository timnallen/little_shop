class Merchant::UsersController < Merchant::BaseController
  def show
    # @orders = Order.merchant_orders
    @orders = Order.all
  end
end
