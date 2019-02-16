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
  end
end
