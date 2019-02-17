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
  end

  def update
  end

  def enable
  end

  def disable
  end

  private

  def item_params
    params[:item][:image] = "https://via.placeholder.com/200x300?text=LittleShop" if params[:item][:image] == ""
    params.require(:item).permit(:name, :description, :image, :price, :quantity)
  end
end
