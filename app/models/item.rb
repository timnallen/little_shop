class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  validates_presence_of :image

  validates :quantity,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true
  }

  validates :price,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0
  }

  validates :name,
    presence: true,
    length: {minimum: 1}

  validates :description,
    presence: true,
    length: {minimum: 1}

  def self.enabled_items
    Item.where(disabled: false)
  end

  def self.top_items(limit)
    items_by_quantity(limit, "desc")
  end

  def self.worst_items(limit)
    items_by_quantity(limit, "asc")
  end

  def self.items_by_quantity(limit, order)
    Item.select(:id, :name, "SUM(order_items.quantity) as quantity")
    .joins(:order_items)
    .where(order_items: {fulfilled: true})
    .group(:id)
    .order("quantity #{order}")
    .limit(limit)
  end

  def average_fulfillment_time
    if order_items.count > 0
      Item.joins(:order_items)
          .where(id: self.id, order_items: {fulfilled: true})
          .select("avg(order_items.updated_at - order_items.created_at) as fulfillment_time")
          .group(:id)[0]
          .fulfillment_time
    else
      "Never been ordered"
    end
  end
end
