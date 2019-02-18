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
      @order_item_1 = create(:order_item, order: @order, item: @item_1, unit_price: 3, quantity: 1)
      @order_item_2 = create(:order_item, order: @order, item: @item_2, unit_price: 2, quantity: 5)
      @order_item_3 = create(:order_item, order: @order, item: @item_3, unit_price: 3, quantity: 10)
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

    it '.ordered_items' do
      @item_1.update(price: "999.99")
      expect(@order.ordered_items.first.unit_price).to eq(@order_item_1.unit_price)
      expect(@order.ordered_items.first.quantity).to eq(@order_item_1.quantity)
      expect(@order.ordered_items.first.name).to eq(@item_1.name)
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
  end
end
