class OrdersController < ApplicationController
  before_action :require_registered

  def index
    user_id = current_user.id
    @orders = Order.where(user_id: user_id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def show
    @order = Order.find(params[:id])
  end
end
