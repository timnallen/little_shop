class ReviewsController < ApplicationController
  before_action :require_user

  def index
    @reviews = Review.where(user_id: current_user.id)
  end

  def new
    @order_item = OrderItem.find(params[:order_item_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = User.find(current_user.id)
    @review.order_item = OrderItem.find(params[:order_item_id])
    if @review.save
      flash[:success] = "You have added a new review to #{@review.order_item.item.name}!"
      redirect_to item_path(@review.order_item.item)
    else
      flash[:danger] = "You are missing required fields."
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:success] = "You have edited your review for #{@review.order_item.item.name}!"
      redirect_to item_path(@review.order_item.item)
    else
      flash[:danger] = "You are missing required fields."
      render :edit
    end
  end

  def destroy
    Review.destroy(params[:id])
    redirect_to profile_reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:title, :description, :rating)
  end
end
