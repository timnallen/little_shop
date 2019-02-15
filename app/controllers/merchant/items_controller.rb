class Merchant::ItemsController < Merchant::BaseController
  def index
    @item = Item.merchant_items(current_user)
  end
end
