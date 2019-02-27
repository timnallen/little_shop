class Review < ApplicationRecord
  belongs_to :user
  belongs_to :order_item
  validates_presence_of :title
  validates_presence_of :description
  validates :rating,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 5
    }

  def item_name
    Item.find_by(id: self.order_item.item_id).name
  end
end
