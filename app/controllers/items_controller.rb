class ItemsController < ApplicationController
  def index
    @items = Item.enabled_items
    @top_items = Item.top_items(5)
  end

  def show
  end
end
