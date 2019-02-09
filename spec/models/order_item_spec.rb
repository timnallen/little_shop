require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'validations' do
    it {should validate_presence_of :quantity}
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :fulfilled}

    it {should validate_numericality_of(:quantity)
      .integer_only
      .greater_than_or_equal_to(1)
    }

    it {should validate_numericality_of(:unit_price)
      .greater_than_or_equal_to(0)
    }
  end

  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :order}
  end

  describe 'instance methods' do
  end

  describe 'class methods' do
  end
end
