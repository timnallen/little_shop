class ReviewsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.item = Item.find(params[:item_id])
    @review.user = User.find(current_user.id)
    if @review.save
      redirect_to item_path(@review.item)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :description, :rating)
  end
end
