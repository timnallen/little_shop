class Merchant::ItemsController < Merchant::BaseController
  def index
    @items = current_user.items
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.new(item_params)
    if @item.save
      flash[:success] = "You have added a new item."
      redirect_to dashboard_items_path
    else
      flash[:danger] = "There are problems with the provided information."
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "Your item has been successfully updated."
      redirect_to dashboard_items_path
    else
      flash[:danger] = "There are problems with the provided information."
      render :edit
    end
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

   private

   def item_params
    params[:item][:image] = "https://via.placeholder.com/200x300?text=LittleShop" if params[:item][:image] == ""
    params.require(:item).permit(:name, :description, :image, :price, :quantity)
  end
end
