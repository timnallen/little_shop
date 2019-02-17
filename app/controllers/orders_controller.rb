class OrdersController < ApplicationController
  before_action :require_registered

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end
end
