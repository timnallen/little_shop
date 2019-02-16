class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  validates_presence_of :status

  def quantity_of_items
    order_items.sum(:quantity)
  end

  def grand_total
    order_items.select("SUM(order_items.unit_price*order_items.quantity) as price_per_item")
              .group(:order_id)[0].price_per_item
  end
end
