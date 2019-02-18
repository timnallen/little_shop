require 'rails_helper'

RSpec.describe Cart do
  describe '#total_count' do
    it 'can calculate the total number of items it holds' do
      cart = Cart.new({
        "1" => {"quantity"=>"2", "unit_price"=>1.0},
        "2" => {"quantity"=>"3", "unit_price"=>1.0}
        })

      expect(cart.total_count).to eq(5)
    end
  end

  describe '#add_item' do
    it 'can add items' do
      cart = Cart.new({
        "1" => {"quantity"=>"2", "unit_price"=>1.0},
        "2" => {"quantity"=>"3", "unit_price"=>1.0}
        })


      item_1_price = cart.contents["1"]["unit_price"]
      item_2_price = cart.contents["2"]["unit_price"]

      cart.add_item("1", item_1_price)
      cart.add_item("2", item_2_price)

      expect(cart.contents).to eq({"1"=>{"quantity"=>"3", "unit_price"=>1.0}, "2"=>{"quantity"=>"4", "unit_price"=>1.0}})
    end

    describe '#total' do
      it 'calculates the grand total for the contents of the cart' do
        merchant = build(:merchant)
        merchant.save

        item_1 = merchant.items.create!(name: "Thing 1", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 20, quantity: 1)
        item_2 = merchant.items.create!(name: "Thing 2", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 30, quantity: 5)

        cart = Cart.new
        item_1_price = item_1.price
        item_2_price = item_2.price

        cart.add_item(item_1.id.to_s, item_1_price)
        cart.add_item(item_1.id.to_s, item_1_price)
        cart.add_item(item_2.id.to_s, item_2_price)
        expect(cart.total).to eq(70)

      end

      it 'returns 0 if the cart is empty' do
        cart = Cart.new
        expect(cart.total).to eq(0)

      end
    end
  end
end
