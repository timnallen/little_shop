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
    items_sold = items_sold_by_quantity
    total_stock = items.sum(:quantity)
    items_sold.to_f / (items_sold + total_stock)
  end

  def top_states(limit)
    items.joins(orders: :user)
         .select('sum(order_items.quantity) as state_quantity, users.state')
         .where(orders: { status: 'completed' })
         .group('users.state')
         .order('state_quantity desc')
         .limit(limit)
  end

  def top_cities(limit)
    items.joins(orders: :user)
         .select("sum(order_items.quantity) as city_quantity, concat(users.city, ', ', users.state) as location")
         .where(orders: { status: 'completed' })
         .group('location')
         .order('city_quantity desc')
         .limit(limit)
  end

  def top_customer_by_orders
  end

  def top_customer_by_items
  end

  def top_spenders
  end
end
