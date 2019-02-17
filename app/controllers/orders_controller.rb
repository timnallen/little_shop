class OrdersController < ApplicationController
  before_action :require_registered

  def index
    @orders = Order.where(user_id: params[:user_id])
  end

  def show
    @order = Order.find(params[:id])
  end
end
