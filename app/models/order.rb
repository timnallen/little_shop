class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  validates_presence_of :status

  def total_items_for_merchant(merchant)
    order_items.joins(:item)
               .where(items: { user: merchant })
               .sum(:quantity)
  end

  def total_value(merchant)
    order_items.joins(:item)
               .where(items: { user: merchant })
               .sum('(order_items.quantity * order_items.unit_price)')
  end

  def self.merchant_orders(merchant)
  end
end
