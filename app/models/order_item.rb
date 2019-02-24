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

  def self.fulf_speed_by_state(state)
    select("order_items.*,(order_items.updated_at - order_items.created_at) as fulf_speed")
    .joins(order: :user)
    .where(users: {state: state})
    .order("fulf_speed asc")
  end

  def subtotal
    unit_price * quantity
  end
end
