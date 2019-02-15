class Merchant::UsersController < Merchant::BaseController
  def show
    # @orders = Order.merchant_orders(merchant)
    @orders = Order.all
  end
end
