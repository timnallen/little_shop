class Admin::MerchantsController < Admin::BaseController
  def show
    @merchant = User.find(params[:id])
    @orders = Order.pending_orders(@merchant)
    redirect_to admin_user_path(@merchant) if @merchant.registered?
  end

  def downgrade
    @merchant = User.find(params[:id])
    @merchant.items.each do |item|
      item.update(disabled: 'true')
    end
    @merchant.update(role: 'registered')
    flash[:primary] = 'You have downgraded a merchant'
    redirect_to admin_user_path(@merchant)
  end
end
