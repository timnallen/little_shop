class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  before_action :require_shopper

  def show
    flash.alert = "Your cart is empty." if @cart.total_count == 0
  end

  def create
    item = Item.find(params[:item_id])
    item_id_str = item.id.to_s
    @cart.add_item(item_id_str)
    session[:cart] = @cart.contents
    quantity = session[:cart][item_id_str]
    flash.notice = "You now have #{pluralize(quantity, "copy")} of #{item.name} in your cart!"
    redirect_to items_path
  end

  private

  def require_shopper
    render file: 'public/404' unless current_shopper?
  end

  def current_shopper?
    !(current_user && (current_user.admin? || current_user.merchant?))
  end
end
