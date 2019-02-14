class ItemsController < ApplicationController
  def index
    @items = Item.enabled_items
    @top_items = Item.top_items(5)
    @worst_items = Item.worst_items(5)
  end

  def show
    @item = Item.find(params[:id])
  end
end
