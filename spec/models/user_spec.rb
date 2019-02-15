require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :email}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zipcode}

    it {should validate_uniqueness_of(:email)}

    it {should validate_numericality_of(:zipcode)
        .only_integer
        }


    it {should validate_length_of(:name)
        .is_at_least(1)
    }

    it {should validate_length_of(:email)
        .is_at_least(1)
    }

    it {should validate_length_of(:address)
        .is_at_least(1)
    }

    it {should validate_length_of(:city)
        .is_at_least(1)
    }

    it {should validate_confirmation_of(:password)}

  end
  describe 'relationships' do
    it {should have_many :orders}
    it {should have_many :items}
  end

  describe 'instance methods' do
    before :each do
      @merchant = create(:merchant)
      @item_1 = create(:item, user: @merchant, quantity: 10)
      @item_2 = create(:item, user: @merchant, quantity: 10)
      @item_3 = create(:item, user: @merchant, quantity: 10)
      @item_4 = create(:item, user: @merchant, quantity: 10)
      @item_5 = create(:item, user: @merchant, quantity: 10)
      @item_6 = create(:item, user: @merchant, quantity: 10)
      @user_1 = create(:user, state: 'California', city: 'Los Angeles')
      @user_2 = create(:user, state: 'Colorado', city: 'Denver')
      @user_3 = create(:user, state: 'Wisconsin', city: 'Wausau')
      @user_4 = create(:user, state: 'Florida', city: 'Miami')
      @order_1 = create(:order, user: @user_1)
      @order_2 = create(:order, user: @user_2)
      @order_3 = create(:order, user: @user_3)
      @order_4 = create(:order, user: @user_3)
      @order_5 = create(:order, user: @user_4)
      create(:order_item, order: @order_1, item: @item_1, unit_price: 100, quantity: 1)
      create(:order_item, order: @order_2, item: @item_2, unit_price: 2, quantity: 2)
      create(:order_item, order: @order_2, item: @item_3, unit_price: 2, quantity: 3)
      create(:order_item, order: @order_3, item: @item_4, unit_price: 2, quantity: 4)
      create(:order_item, order: @order_4, item: @item_6, unit_price: 2, quantity: 5)
    end
    describe '.top_items' do
      it 'returns an array of the top 5 items sold by quantity and the quantity of each sold for a specific merchant' do
        expect(@merchant.top_items).to eq([@order_6, @order_4, @order_3, @order_2, @order_1])
        expect(@merchant.top_items.first.quantity).to eq(5)
      end
    end

    describe '.items_sold' do
      it 'returns the total quantity of items sold along with a percentage of total inventory for a specific merchant' do
        expect(@merchant.items_sold).to eq([15, 25])
      end
    end

    describe '.top_cities' do
      it 'returns an array of the top 3 cities where the most items were sold by a specific merchant along with the quantity shipped to each state' do
        expect(@merchant.top_cities).to eq([['Wausau, WI', 9], ['Denver, CO', 5], 'Los Angeles, CA', 1])
      end
    end

    describe '.top_customer_orders' do
      it 'returns the user with the most orders containing a specific merchant\'s items, along with their total number of orders' do
        expect(@merchant.top_customer_orders).to eq(@user_3)
        expect(@merchant.top_customer_orders.total_orders).to eq(2)
      end
    end

    describe '.top_customer_items' do
      it 'returns the user who has ordered the most items from a specific merchant, along with the total quantity of items ordered' do
        expect(@merchant.top_customer_items).to eq(@user_3)
        expect(@merchant.top_customer_items.total_items).to eq(9)
      end
    end

    describe '.top_spenders' do
      it 'returns the top 3 users who have spent the most money on a specific merchant\'s items, along with the total amount spent by each' do
        expect(@merchant.top_spenders).to eq([@user_1, @user_3, @user_2])
        expect(@merchant.top_spenders.first.total_amount).to eq(100)
      end
    end
  end

  describe 'class methods' do
  end
end
