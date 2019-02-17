class Admin::MerchantsController < Admin::BaseController
  def show
    @merchant = User.find(params[:id])
    @orders = Order.pending_orders(@merchant)
    redirect_to admin_user_path(@merchant) if @merchant.registered?
  end
end
