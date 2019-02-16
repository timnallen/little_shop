class Merchant::ItemsController < Merchant::BaseController
  def index
    @items = current_user.items
  end

  def enable
    Item.find(params[:id]).update(disabled: false)
    flash[:success] = "Item ##{params[:id]} is now available for sale."
    redirect_to dashboard_items_path
  end
end
