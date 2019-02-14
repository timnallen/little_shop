require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it {should validate_presence_of :quantity}
    it {should validate_presence_of :price}
    it {should validate_presence_of :name}
    it {should validate_presence_of :image}
    it {should validate_presence_of :description}

    it {should validate_numericality_of(:quantity)
      .is_greater_than_or_equal_to(0)
      .only_integer
    }

    it {should validate_numericality_of(:price)
      .is_greater_than_or_equal_to(0)
    }

    it {should validate_length_of(:name)
        .is_at_least(1)
    }

    it {should validate_length_of(:description)
        .is_at_least(1)
    }
  end

  describe 'relationships' do
    it {should have_many :order_items}
    it {should belong_to :user}
  end

  describe 'instance methods' do
  end

  describe 'class methods' do
    it '.enabled_items' do
      merchant = build(:merchant)
      merchant.save
      item_1 = merchant.items.create(name: "Thing 1", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 20.987, quantity: 1)
      item_2 = merchant.items.create(name: "Thing 2", description: "It's another thing", image: "http://www.stickpng.com/assets/thumbs/580b585b2edbce24c47b2a2c.png", price: 1.0, quantity: 444, disabled: true)

      expect(Item.enabled_items).to eq([item_1])
    end

    it 'top_items' do
      merchant = build(:merchant)
      merchant.save
      user = build(:user)
      user.save
      order = user.orders.create
      item_1 = merchant.items.create!(name: "Item 1", description: "Description 1", price: 1.11, quantity: 10, image: "test.png")
      item_2 = merchant.items.create(name: "Item 2", description: "Description 2", price: 2.22, quantity: 10, image: "test.png")
      item_3 = merchant.items.create(name: "Item 3", description: "Description 3", price: 3.33, quantity: 10, image: "test.png")
      item_4 = merchant.items.create(name: "Item 4", description: "Description 4", price: 4.44, quantity: 10, image: "test.png")
      item_5 = merchant.items.create(name: "Item 5", description: "Description 5", price: 5.55, quantity: 10, image: "test.png")
      order_items = []
      order_items << OrderItem.create(order: order, item: item_1, unit_price: item_1.price, quantity: 1)
      order_items << OrderItem.create(order: order, item: item_2, unit_price: item_2.price, quantity: 2)
      order_items << OrderItem.create(order: order, item: item_3, unit_price: item_3.price, quantity: 3)
      order_items << OrderItem.create(order: order, item: item_4, unit_price: item_4.price, quantity: 4)
      order_items << OrderItem.create(order: order, item: item_5, unit_price: item_5.price, quantity: 5)
      order_items.each {|order_item| order_item.update(fulfilled: true)}

      top_items = Item.top_items(5)
      binding.pry

      expect([top_items[0].name, top_items[0].quantity]).to eq([item_5.name, order_items[4].quantity])
      expect([top_items[1].name, top_items[1].quantity]).to eq([item_4.name, order_items[3].quantity])
      expect([top_items[2].name, top_items[2].quantity]).to eq([item_3.name, order_items[2].quantity])
      expect([top_items[3].name, top_items[3].quantity]).to eq([item_2.name, order_items[1].quantity])
      expect([top_items[4].name, top_items[4].quantity]).to eq([item_1.name, order_items[0].quantity])
    end
  end
end
