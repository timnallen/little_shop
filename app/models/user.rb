class User < ApplicationRecord
  has_secure_password

  enum role: ['registered', 'merchant', 'admin']

  validates :name,
    presence: true,
    length: {minimum: 1}

  validates :city,
    presence: true,
    length: {minimum: 1}

  validates :password,
    # presence: true,
    # length: {minimum: 1}
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

  validates :role,
    presence: true

  has_many :orders
  has_many :items

end
