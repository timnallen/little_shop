require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it {should validate_presence_of :status}
  end

  describe 'relationships' do
    it {should belong_to :user}
    it {should have_many :order_items}
    it {should have_many :items}
  end

  describe 'instance methods' do
    before :each do
      @user = create(:user)
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @item_1 = create(:item, user: @merchant_1)
      @item_2 = create(:item, user: @merchant_1)
      @item_3 = create(:item, user: @merchant_2)
      @order = create(:order, user: @user)
      create(:order_item, order: @order, item: @item_1, unit_price: 3, quantity: 1)
      create(:order_item, order: @order, item: @item_2, unit_price: 2, quantity: 5)
      create(:order_item, order: @order, item: @item_3, unit_price: 3, quantity: 10)
    end
    describe '.total_items_for_merchant(merchant)' do
      it 'returns the total quantity of a merchant\'s items in an order' do

        expect(@order.total_items_for_merchant(@merchant_1)).to eq(6)
      end
    end

    describe '.total_value_for_merchant(merchant)' do
      it 'returns the total value of a specific merchant\'s items in an order' do

        expect(@order.total_value_for_merchant(@merchant_1)).to eq(13)
      end
    end

    it '.quantity_of_items' do
      user = create(:user)
      item_1 = create(:item)
      item_2 = create(:item)
      order = create(:order, user: user)
      create(:order_item, order: order, item: item_1, quantity: 2)
      create(:order_item, order: order, item: item_2, quantity: 1)

      expect(order.quantity_of_items).to eq(3)
    end

    it '.grand_total' do
      user = create(:user)
      item_1 = create(:item)
      item_2 = create(:item)
      order = create(:order, user: user)
      create(:order_item, order: order, item: item_1, unit_price: 1.50, quantity: 2)
      create(:order_item, order: order, item: item_2, unit_price: 3.50, quantity: 1)

      expect(order.grand_total).to eq(6.5)
    end
  end

  describe 'class methods' do
    describe '.pending_orders(merchant)' do
      it 'returns an array of all pending orders containing a specific merchant\'s items' do
        user = create(:user)
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        item_1 = create(:item, user: merchant_1)
        item_2 = create(:item, user: merchant_2)
        order_1 = create(:order, user: user)
        order_2 = create(:order, user: user)
        order_3 = create(:order, user: user)
        order_4 = create(:cancelled_order, user: user)
        order_5 = create(:completed_order, user: user)
        create(:order_item, order: order_1, item: item_1, unit_price: 1, quantity: 1)
        create(:order_item, order: order_2, item: item_2, unit_price: 1, quantity: 1)
        create(:order_item, order: order_3, item: item_1, unit_price: 1, quantity: 1)
        create(:order_item, order: order_4, item: item_1, unit_price: 1, quantity: 1)
        create(:order_item, order: order_5, item: item_1, unit_price: 1, quantity: 1)

        expect(Order.pending_orders(merchant_1)).to eq([order_1, order_3])
      end
    end
    describe '.top_states' do
      before :each do
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
        create(:order_item, order: @order_1, item: @item_1, fulfilled: true)
        @order_2 = create(:order, user: @user_1, status: 'completed')
        create(:order_item, order: @order_2, item: @item_1, fulfilled: true)
        @order_3 = create(:order, user: @user_1, status: 'completed')
        create(:order_item, order: @order_3, item: @item_1, fulfilled: true)
        @order_4 = create(:order, user: @user_1, status: 'completed')
        create(:order_item, order: @order_4, item: @item_1, fulfilled: true)


        #User 2 from Florida's 3 orders:
        @order_5 = create(:order, user: @user_2, status: 'completed')
        create(:order_item, order: @order_5, item: @item_1, fulfilled: true)
        @order_6 = create(:order, user: @user_2, status: 'completed')
        create(:order_item, order: @order_6, item: @item_1, fulfilled: true)
        @order_7 = create(:order, user: @user_2, status: 'completed')
        create(:order_item, order: @order_7, item: @item_1, fulfilled: true)

        #User 3 from Wisconsin's 2 orders
        @order_8 = create(:order, user: @user_3, status: 'completed')
        create(:order_item, order: @order_8, item: @item_1, fulfilled: true)
        @order_9 = create(:order, user: @user_3, status: 'completed')
        create(:order_item, order: @order_9, item: @item_1, fulfilled: true)

        #User 4 from Wisconsin's 3 orders
        @order_10 = create(:order, user: @user_4, status: 'completed')
        create(:order_item, order: @order_10, item: @item_1, fulfilled: true)
        @order_11 = create(:order, user: @user_4, status: 'completed')
        create(:order_item, order: @order_11, item: @item_1, fulfilled: true)
        @order_12 = create(:order, user: @user_4, status: 'completed')
        create(:order_item, order: @order_12, item: @item_1, fulfilled: true)

        #User 5, from Colorado's two orders
        @order_13 = create(:order, user: @user_5, status: 'completed')
        create(:order_item, order: @order_13, item: @item_1, fulfilled: true)
        @order_14 = create(:order, user: @user_5, status: 'completed')
        create(:order_item, order: @order_14, item: @item_1, fulfilled: true)

      end
      it 'should return the top 3 states where any orders were shipped (by number of orders), and count of orders' do
        expect(Order.top_states[0].state).to eq("Wisconsin")
        expect(Order.top_states[1].state).to eq("California")
        expect(Order.top_states[2].state).to eq("Florida")
        expect(Order.top_states[0].order_count).to eq(5)
        expect(Order.top_states[1].order_count).to eq(4)
        expect(Order.top_states[2].order_count).to eq(3)
      end

      it '' do
      end 
    end
  end
end
