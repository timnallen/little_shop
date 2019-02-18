require 'rails_helper'

RSpec.describe 'when I visit the merchant index page' do
  before :each do
    @active_merchants = create_list(:merchant, 4)

    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    @merchant_5 = create(:merchant)
    @merchant_6 = create(:merchant)
    @merchant_7 = create(:merchant)

    @item_1 = create(:item, user: @merchant_1, quantity: 100, price: 30)
    @item_2 = create(:item, user: @merchant_1, quantity: 100, price: 27)
    @item_3 = create(:item, user: @merchant_1, quantity: 100, price: 22)
    @item_4 = create(:item, user: @merchant_2, quantity: 100, price: 33)
    @item_5 = create(:item, user: @merchant_2, quantity: 100, price: 14)
    @item_6 = create(:item, user: @merchant_3, quantity: 100, price: 15)
    @item_7 = create(:item, user: @merchant_3, quantity: 100, price: 16)
    @item_8 = create(:item, user: @merchant_4, quantity: 100, price: 17)
    @item_9 = create(:item, user: @merchant_4, quantity: 100, price: 20)
    @item_10 = create(:item, user: @merchant_5, quantity: 100, price: 21.70)
    @item_11 = create(:item, user: @merchant_6, quantity: 100, price: 22)
    @item_12 = create(:item, user: @merchant_7, quantity: 1000, price: 23)

    @user_1 = create(:user, state: 'California', city: 'Los Angeles')
    @user_2 = create(:user, state: 'Florida', city: 'Wausau')
    @user_3 = create(:user, state: 'Wisconsin', city: 'Wausau')
    @user_4 = create(:user, state: 'Wisconsin', city: 'Green Bay')

    @order_1 = create(:order, user: @user_1, status: 'completed')
    @order_2 = create(:order, user: @user_2, status: 'pending')
    @order_3 = create(:order, user: @user_3, status: 'completed')
    @order_4 = create(:order, user: @user_3, status: 'completed')
    @order_5 = create(:order, user: @user_4, status: 'completed')
    @order_6 = create(:order, user: @user_1, status: 'cancelled')

    create(:order_item, order: @order_1, item: @item_1, unit_price: 30, quantity: 100)
    create(:order_item, order: @order_1, item: @item_2, unit_price: 27, quantity: 70)
    create(:order_item, order: @order_1, item: @item_4, unit_price: 33, quantity: 3)
    #order_1 total cost = $4,989. $4,890 for merchant 1 and $99 for merchant 2
    create(:order_item, order: @order_2, item: @item_12, unit_price: 23, quantity: 1000)
    #order_2 total revenue = $23,000

    create(:order_item, order: @order_3, item: @item_2, unit_price: 20, quantity: 4)

    create(:order_item, order: @order_5, item: @item_7, unit_price: 7, quantity: 1)
    create(:order_item, order: @order_2, item: @item_8, unit_price: 8, quantity: 1)
    create(:order_item, order: @order_4, item: @item_9, unit_price: 9, quantity: 1)
    binding.pry
    end

  context 'as a visitor' do
    it "I see a list of all merchants in the system" do
      visit merchants_path

      @active_merchants.each do |merchant|
        within "#merchant-#{merchant.id}" do
          expect(page).to have_content(merchant.name)
        end
      end
    end

    it 'I only see merchants who are active' do
      inactive_merchant = build(:inactive_merchant)
      inactive_merchant.save

      visit merchants_path

      expect(page).to_not have_css("#merchant-#{inactive_merchant.id}")
      expect(page).to_not have_content(inactive_merchant.name)
    end

    it "Next to each merchants name I also see their city and state" do
      visit merchants_path

      @active_merchants.each do |merchant|
        within "#merchant-#{merchant.id}" do
          expect(page).to have_content("From: #{merchant.city}, #{merchant.state}")
        end
      end
    end

    it "I also see the date each merchant registered" do
      visit merchants_path

      @active_merchants.each do |merchant|
        within "#merchant-#{merchant.id}" do
          expect(page).to have_content("Registered: #{merchant.created_at}")
        end
      end
    end

    describe 'in the statistics section of the page' do
      it 'I see top 3 merchants who have sold the most and their revenue' do



      end

      it 'I see top 3 fastest merchants and their times' do
      end

      it 'I see slowest 3 merchants and their times' do
      end

      it 'I see top 3 states by number of orders and count of orders' do
      end

      it 'I see top 3 cities and the count of orders' do
      end

      it 'I see top 3 biggest orders by quantity of items and their quantities' do
      end
    end
  end

  context 'as an admin' do
    before :each do
      @admin = build(:admin)
      @admin.save
    end

    it 'next to each active merchants name I see a button to disable them' do
      login_as(@admin)
      visit merchants_path

      @active_merchants.each do |merchant|
        within "#merchant-#{merchant.id}" do
          expect(page).to have_button("Disable")
        end
      end
    end

    it 'next to each inactive_merchant I see a button to enable them' do
      inactive_merchant = build(:inactive_merchant)
      inactive_merchant.save
      login_as(@admin)
      visit merchants_path

      within "#merchant-#{inactive_merchant.id}" do
        expect(page).to have_button("Enable")
      end
    end

    it 'each merchant name is a link to their dashboard' do
      login_as(@admin)
      visit merchants_path

      @active_merchants.each do |merchant|
        within "#merchant-#{merchant.id}" do
          expect(page).to have_link(merchant.name)
        end
      end
    end

    it 'I can click the button to disable an enabled merchant' do
      login_as(@admin)

      visit merchants_path

      within "#merchant-#{@active_merchants.first.id}" do
        click_button 'Disable'
      end

      expect(page).to have_content "You have disabled a user"

      within "#merchant-#{@active_merchants.first.id}" do
        expect(page).to have_button('Enable')
      end

      click_link 'Logout'

      login_as(@active_merchants.first)

      expect(page).to have_content 'Invalid email and/or password'
    end

    it 'I can click a link to enable a disabled merchant' do
      inactive_merchant = build(:inactive_merchant)
      inactive_merchant.save
      login_as(@admin)

      visit merchants_path

      within "#merchant-#{inactive_merchant.id}" do
        click_button 'Enable'
      end

      expect(page).to have_content "You have enabled a user"

      within "#merchant-#{inactive_merchant.id}" do
        expect(page).to have_button('Disable')
      end

      click_link 'Logout'

      login_as(inactive_merchant)

      expect(page).to have_content("You are now logged in")
    end
  end
end
