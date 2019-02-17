class Admin::ItemsController < Admin::BaseController
  def index
    @merchant = User.find(params[:merchant_id])
    @items = @merchant.items
    render :'merchant/items/index'
  end

  def new
    @merchant = User.find(params[:merchant_id])
    @item = @merchant.items.new
  end

  def create
    @merchant = User.find(params[:merchant_id])
    @item = @merchant.items.new(item_params)
    if @item.save
      flash[:success] = "You have added an item."
      redirect_to admin_merchant_items_path(@merchant)
    else
      flash[:danger] = "There are problems with the provided information."
      render :new
    end
  end

  def edit
    @merchant = User.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = User.find(params[:merchant_id])
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "Item ##{@item.id} has successfully been updated."
      redirect_to admin_merchant_items_path(@merchant)
    else
      flash[:danger] = "There are problems with the provided information."
      render :edit
    end
  end

  def destroy
    item = Item.destroy(params[:id])
    flash[:danger] = "Item ##{params[:id]} has been deleted."
    redirect_to admin_merchant_items_path(item.user_id)
  end

  def enable
    Item.find(params[:id]).update(disabled: false)
    flash[:success] = "Item ##{params[:id]} is now available for sale."
    redirect_to admin_merchant_items_path(params[:merchant_id])
  end

  def disable
    Item.find(params[:id]).update(disabled: true)
    flash[:warning] = "Item ##{params[:id]} is no longer available for sale."
    redirect_to admin_merchant_items_path(params[:merchant_id])
  end

  private

  def item_params
    params[:item][:image] = "https://via.placeholder.com/200x300?text=LittleShop" if params[:item][:image] == ""
    params.require(:item).permit(:name, :description, :image, :price, :quantity)
  end
end
