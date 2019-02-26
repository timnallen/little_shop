class ReviewsController < ApplicationController
  before_action :require_user

  def index
    @reviews = Review.where(user_id: current_user.id)
  end

  def new
    @item = Item.find(params[:item_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.item = Item.find(params[:item_id])
    @review.user = User.find(current_user.id)
    if @review.save
      flash[:success] = "You have added a new review to #{@review.item.name}!"
      redirect_to item_path(@review.item)
    else
      @item = @review.item
      flash[:danger] = "You are missing required fields."
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
    @item = @review.item
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:success] = "You have edited your review for #{@review.item.name}!"
      redirect_to item_path(@review.item)
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
