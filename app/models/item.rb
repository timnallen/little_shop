class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items

  validates_presence_of :image
  validates_presence_of :disabled

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
end
