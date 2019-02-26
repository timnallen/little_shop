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
    it {should have_one :review}
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
  end
end
