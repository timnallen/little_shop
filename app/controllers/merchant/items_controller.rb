class Merchant::ItemsController < Merchant::BaseController
  def index
    @items = current_user.items
  end

  def new
    @item = Item.new
  end

  def create
    item = current_user.items.create!(item_params)
    flash[:success] = "You have added a new item."
    redirect_to dashboard_items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :image, :price, :quantity)
  end
end
