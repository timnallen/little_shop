class Admin::ItemsController < Admin::BaseController
  def index
    @items = Item.where(user_id: params[:merchant_id])
    render :'merchant/items/index'
  end
end
