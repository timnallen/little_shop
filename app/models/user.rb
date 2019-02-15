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

  def top_items
  end

  def items_sold
    total_quantity = Item.where(user_id: self).sum(:quantity)
  end

  def top_cities
  end

  def top_customer_orders
  end

  def top_customer_items
  end

  def top_spenders
  end
end
