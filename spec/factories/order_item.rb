FactoryBot.define do
  factory :order_item do
    order
    item
    sequence(:quantity) { |n| ("#{n}".to_i+1)*2 }
    unit_price {item.price}
    fulfilled { false }
  end

  factory :fulfilled_order_item, parent: :order_item do
    fulfilled { true }
  end
end
