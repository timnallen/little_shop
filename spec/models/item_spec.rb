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
    it {should have_many :orders}
    it {should belong_to :user}
  end

  describe 'instance methods' do
    it '.average_fulfillment_time' do
      merchant = build(:merchant)
      merchant.save
      item_1 = merchant.items.create(name: "Thing 1", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 20.987, quantity: 1)
      user = build(:user)
      user.save
      order = user.orders.create
      order_2 = user.orders.create
      order_item_1 = OrderItem.create(item: item_1, order: order, quantity: 2, unit_price: item_1.price)
      order_item_2 = OrderItem.create(item: item_1, order: order_2, quantity: 3, unit_price: item_1.price)
      sleep 2

      order_item_1.update(fulfilled: true)
      sleep 2
      order_item_2.update(fulfilled: true)

      expect(item_1.average_fulfillment_time).to eq("00 hours 00 minutes 03 seconds")
    end
  end

  describe 'class methods' do
    it '.enabled_items' do
      merchant = build(:merchant)
      merchant.save
      item_1 = merchant.items.create(name: "Thing 1", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 20.987, quantity: 1)
      merchant.items.create(name: "Thing 2", description: "It's another thing", image: "http://www.stickpng.com/assets/thumbs/580b585b2edbce24c47b2a2c.png", price: 1.0, quantity: 444, disabled: true)
      item_3 = merchant.items.create(name: "Thing 3", description: "It's THE thing", image: "http://www.pngmart.com/files/6/Thing-PNG-File-1.png", price: 10.0, quantity: 4)

      expect(Item.enabled_items).to eq([item_1, item_3])
    end
  end
end
