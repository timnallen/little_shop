class Admin::MerchantsController < Admin::BaseController
  def show
    @user = User.find(params[:id])
    @orders = Order.pending_orders(@user)
    redirect_to admin_user_path(@user) if @user.registered?
    render '/merchant/users/show' if @user.merchant?
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
