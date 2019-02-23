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

  def self.by_state(state)
    joins(order: :user)
    .where(users: {state: state})
    .order(:updated_at)
  end

  def subtotal
    unit_price * quantity
  end
end
