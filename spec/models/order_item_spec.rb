require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'validations' do
    it {should validate_presence_of :quantity}
    it {should validate_presence_of :unit_price}

    it {should validate_numericality_of(:quantity)
      .only_integer
      .is_greater_than_or_equal_to(1)
    }

    it {should validate_numericality_of(:unit_price)
      .is_greater_than_or_equal_to(0)
    }
  end

  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :order}
  end

  describe 'instance methods' do
    it '.subtotal' do
      user = create(:user)
      item_1 = create(:item)
      order = create(:order, user: user)
      order_item_1 = create(:order_item, unit_price: 2.50, quantity: 2, order: order, item: item_1)

      expect(order_item_1.subtotal).to eq(5.0)
    end
  end

  describe 'class methods' do
    it '.by_state' do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)
      @merchant_4 = create(:merchant)

      @user_1 = create(:user, state: 'California', city: 'Los Angeles')
      @user_2 = create(:user, state: 'Florida', city: 'Wausau')
      @user_3 = create(:user, state: 'Wisconsin', city: 'Wausau')
      @user_4 = create(:user, state: 'Wisconsin', city: 'Green Bay')
      @user_5 = create(:user, state: 'Colorado', city: 'Denver')


      @item_1 = create(:item, user: @merchant_1, quantity: 100, price: 30)
      @item_2 = create(:item, user: @merchant_1, quantity: 100, price: 20)
      @item_3 = create(:item, user: @merchant_2, quantity: 100, price: 17)
      @item_4 = create(:item, user: @merchant_3, quantity: 100, price: 5)
      @item_5 = create(:item, user: @merchant_4, quantity: 100, price: 3)
      @item_6 = create(:item, user: @merchant_2, quantity: 100, price: 3)


      @order_1 = create(:order, user: @user_1, status: 'completed')
      create(:order_item, order: @order_1, item: @item_1, unit_price: 30, quantity: 30, fulfilled: true, created_at: 60.seconds.ago, updated_at: 1.second.ago)
      create(:order_item, order: @order_1, item: @item_2, unit_price: 20, quantity: 20, fulfilled: true, created_at: 58.seconds.ago, updated_at: 1.second.ago)
      create(:order_item, order: @order_1, item: @item_6, unit_price: 3, quantity: 3, fulfilled: true, created_at: 31.seconds.ago, updated_at: 1.second.ago)

      @order_2 = create(:order, user: @user_1, status: 'pending')
      create(:order_item, order: @order_2, item: @item_3, unit_price: 17, quantity: 17, fulfilled: true, created_at: 32.seconds.ago, updated_at: 1.second.ago)

      @order_3 = create(:order, user: @user_1, status: 'completed')
      create(:order_item, order: @order_3, item: @item_4, unit_price: 5, quantity: 5, fulfilled: true, created_at: 4.seconds.ago, updated_at: 1.second.ago)
      create(:order_item, order: @order_3, item: @item_5, unit_price: 3, quantity: 3, fulfilled: true, created_at: 30.seconds.ago, updated_at: 28.seconds.ago)

      @merchant_5 = create(:merchant)
      @merchant_6 = create(:merchant)
      @merchant_7 = create(:merchant)
      @merchant_8 = create(:merchant)
      @merchant_9 = create(:merchant)
      @merchant_10 = create(:merchant)
      @merchant_11 = create(:merchant)
      @merchant_12 = create(:merchant)
      @item_7 = create(:item, user: @merchant_5, quantity: 1000)
      @item_8 = create(:item, user: @merchant_6, quantity: 1000)
      @item_9 = create(:item, user: @merchant_7, quantity: 1007)
      @item_10 = create(:item, user: @merchant_8, quantity: 100)
      @item_11 = create(:item, user: @merchant_9, quantity: 100)
      @item_12 = create(:item, user: @merchant_10, quantity: 100)
      @item_13 = create(:item, user: @merchant_11, quantity: 100)
      @item_14 = create(:item, user: @merchant_12, quantity: 100)
      @order_4 = create(:order, user: @user_2, status: 'completed')
      create(:order_item, order: @order_4, item: @item_7, quantity: 10, fulfilled: true, created_at: 40.days.ago, updated_at: 1.day.ago)

      @order_5 = create(:order, user: @user_3, status: 'pending')
      oi_1 = create(:order_item, order: @order_5, item: @item_7, quantity: 1, fulfilled: true, created_at: 5.days.ago, updated_at: 1.day.ago)
      oi_2 = create(:order_item, order: @order_5, item: @item_8, quantity: 4, fulfilled: true, created_at: 6.days.ago, updated_at: 1.day.ago)

      @order_6 = create(:order, user: @user_4, status: 'completed')
      oi_3 = create(:order_item, order: @order_6, item: @item_11, quantity: 19, fulfilled: true, created_at: 4.days.ago, updated_at: 1.day.ago)
      oi_4 = create(:order_item, order: @order_6, item: @item_12, quantity: 9, fulfilled: true, created_at: 30.days.ago, updated_at: 29.seconds.ago)

      expect(OrderItem.by_state(@user_3.state)).to eq([oi_1, oi_2, oi_3, oi_4])
    end
  end
end
