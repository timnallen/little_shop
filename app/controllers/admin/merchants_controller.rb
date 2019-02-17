class Admin::MerchantsController < Admin::BaseController
  def show
    @merchant = User.find(params[:id])
    @orders = Order.pending_orders(@merchant)
  end
end
