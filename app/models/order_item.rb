class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :unit_price,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0
  }

  validates :quantity,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 1,
      only_integer: true
  }
end
