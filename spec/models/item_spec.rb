require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it {should validate_presence_of :quantity}
    it {should validate_presence_of :price}
    it {should validate_presence_of :name}
    it {should validate_presence_of :image}
    it {should validate_presence_of :disabled}
    it {should validate_presence_of :description}

    it {should validate_numericality_of(:quantity)
      .is_greater_than_or_equal_to(0)
      .only_integer
    }

    it {should validate_numericality_of(:price)
      .is_greater_than_or_equal_to(0)
    }

    it {should validate_length_of(:name)
        .is_at_least(1)
    }

    it {should validate_length_of(:description)
        .is_at_least(1)
    }
  end

  describe 'relationships' do
    it {should have_many :order_items}
    it {should belong_to :user}
  end

  describe 'instance methods' do
  end

  describe 'class methods' do
  end
end
