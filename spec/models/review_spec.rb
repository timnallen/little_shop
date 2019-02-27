require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :description}
    it {should validate_numericality_of(:rating)
      .only_integer
      .is_greater_than_or_equal_to(1)
      .is_less_than_or_equal_to(5)
    }
  end

  describe 'relationships' do
    it {should belong_to :order_item}
    it {should belong_to :user}
  end

  describe 'instance methods' do
    it '.item_name' do
      @user = create(:user)
      @item = create(:item)
      @order = create(:order, user: @user)
      @order_item = create(:order_item, order: @order, item: @item)
      @review = Review.create(order_item: @order_item, user: @user, title: "Loved this item", description: "Best item I ever purchased", rating: 5)

      expect(@review.item_name).to eq(@item.name)
    end
  end
end
