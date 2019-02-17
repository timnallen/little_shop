class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  before_action :require_shopper

  def show
    set_cart
    flash[:primary] = "Your cart is empty." if @cart.total_count == 0

    if !current_user && @cart.total_count > 0
      flash[:primary] = %Q[You must #{view_context.link_to("login", login_path)} or  #{view_context.link_to("register", register_path)} to checkout.]
    end
    @items = {}
    @cart.contents.each do |item, quantity|
      @items[Item.find(item)] = quantity.to_i
    end
  end

  def create
    item = Item.find(params[:item_id])
    item_id_str = item.id.to_s
    @cart.add_item(item_id_str)
    session[:cart] = @cart.contents
    quantity = session[:cart][item_id_str]
    flash[:success] = "You now have #{pluralize(quantity, "copy")} of #{item.name} in your cart!"
    redirect_to items_path
  end

  private

  def require_shopper
    render file: 'public/404' unless current_shopper?
  end
end
