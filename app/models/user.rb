class User < ApplicationRecord
  validates :name,
    presence: true,
    length: {minimum: 1}

  validates :city,
    presence: true,
    length: {minimum: 1}

  validates :password,
    presence: true,
    length: {minimum: 1},
    confirmation: true

  validates :address,
    presence: true,
    length: {minimum: 1}

  validates :email,
    presence: true,
    length: {minimum: 1},
    uniqueness: true

  validates :state,
    presence: true,
    length: {is: 2}

  validates :zipcode,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 99999,
      only_integer: true
  }

  validates :role,
    presence: true

  has_many :orders
  has_many :items

end
