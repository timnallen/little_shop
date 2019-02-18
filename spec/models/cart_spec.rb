require 'rails_helper'

RSpec.describe Cart do
  before :each do
    @cart = Cart.new({
      "1" => "2",
      "2" => "3"
      })
  end
  describe '#total_count' do
    it 'can calculate the total number of items it holds' do
      expect(@cart.total_count).to eq(5)
    end
  end

  describe '#add_item' do
    it 'can calculate the total number of items it holds' do
      @cart.add_item("1")
      @cart.add_item("2")

      expect(@cart.contents).to eq("1" => "3", "2" => "4")
    end
  end

  describe '#remove_item' do
    it 'can decrement an item' do
      @cart.remove_item("1")
      expect(@cart.contents).to eq("1" => "1", "2" => "3")
    end

    it 'deletes the key if value reaches zero an item' do
      @cart.remove_item("1")
      @cart.remove_item("1")
      expect(@cart.contents).to eq("2" => "3")
    end
  end

  describe '#clear_item' do
    it 'removes all of a given item' do
      @cart.clear_item("1")
      expect(@cart.contents).to eq("2" => "3")
    end
  end

  describe '#total' do
    it 'calculates the grand total for the contents of the cart' do
      merchant = build(:merchant)
      merchant.save
      cart = Cart.new(Hash.new)

      item_1 = merchant.items.create!(name: "Thing 1", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 20, quantity: 1)
      item_2 = merchant.items.create!(name:"Thing 2", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 30, quantity: 5)

      cart.add_item(item_1.id.to_s)
      cart.add_item(item_1.id.to_s)
      cart.add_item(item_2.id.to_s)
      expect(cart.total).to eq(70)
    end

    it 'returns 0 if the cart is empty' do
      cart = Cart.new(Hash.new)
      expect(cart.total).to eq(0)
    end
  end
end
