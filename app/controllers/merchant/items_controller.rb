class Merchant::ItemsController < Merchant::BaseController
  def index
    @items = current_user.items
  end

  def enable
    Item.find(params[:id]).update(disabled: false)
    flash[:success] = "Item ##{params[:id]} is now available for sale."
    redirect_to dashboard_items_path
  end

  def disable
    Item.find(params[:id]).update(disabled: true)
    flash[:warning] = "Item ##{params[:id]} is no longer available for sale."
    redirect_to dashboard_items_path
  end

  def destroy
    Item.find(params[:id]).destroy
    flash[:danger] = "Item ##{params[:id]} has been deleted."
    redirect_to dashboard_items_path
  end
end
