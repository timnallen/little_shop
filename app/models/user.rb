class User < ApplicationRecord
  has_many :orders
  has_many :items

  has_secure_password

  enum role: ['registered', 'merchant', 'admin']

  validates :name,
    presence: true,
    length: {minimum: 1}

  validates :city,
    presence: true,
    length: {minimum: 1}

  validates :password,
    confirmation: true

  validates :address,
    presence: true,
    length: {minimum: 1}

  validates :email,
    presence: true,
    length: {minimum: 1},
    uniqueness: true

  validates :state,
    presence: true

  validates :zipcode,
    presence: true,
    numericality: {
      only_integer: true
  }

  def top_items_for_merchant(limit)
    items.joins(:orders)
         .where(orders: { status: 'completed' })
         .select('items.*, sum(order_items.quantity) as total_quantity')
         .group(:id)
         .order('total_quantity desc')
         .limit(limit)
  end

  def items_sold_by_quantity
    items.joins(:orders)
         .where(orders: { status: 'completed' })
         .sum('order_items.quantity')
  end

  def items_sold_by_percentage

  end

  def top_cities
  end

  def top_customer_by_orders
  end

  def top_customer_by_items
  end

  def top_spenders
  end
end
