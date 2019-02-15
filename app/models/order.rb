class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  validates_presence_of :status

  def total_items(merchant)
  end

  def total_value(merchant)
  end

  def self.merchant_orders(merchant)
  end
end
