require 'rails_helper'

include ApplicationHelper

RSpec.describe 'when I visit the merchant index page' do
  before :each do
    @active_merchants = create_list(:merchant, 4)

    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)

    @user_1 = create(:user, state: 'California', city: 'Los Angeles')
    @user_2 = create(:user, state: 'Florida', city: 'Wausau')
    @user_3 = create(:user, state: 'Wisconsin', city: 'Wausau')
    @user_4 = create(:user, state: 'Wisconsin', city: 'Green Bay')
    @user_5 = create(:user, state: 'Colorado', city: 'Denver')


    @item_1 = create(:item, user: @merchant_1, quantity: 100, price: 30)
    @item_2 = create(:item, user: @merchant_1, quantity: 100, price: 20)
    @item_3 = create(:item, user: @merchant_2, quantity: 100, price: 17)
    @item_4 = create(:item, user: @merchant_3, quantity: 100, price: 5)
    @item_5 = create(:item, user: @merchant_4, quantity: 100, price: 3)
    @item_6 = create(:item, user: @merchant_2, quantity: 100, price: 3)

    @order_1 = create(:order, user: @user_1, status: 'completed')
    create(:order_item, order: @order_1, item: @item_1, unit_price: 30, quantity: 30, fulfilled: true, created_at: 60.seconds.ago, updated_at: 1.second.ago)
    create(:order_item, order: @order_1, item: @item_2, unit_price: 20, quantity: 20, fulfilled: true, created_at: 58.seconds.ago, updated_at: 1.second.ago)
    create(:order_item, order: @order_1, item: @item_6, unit_price: 3, quantity: 3, fulfilled: true, created_at: 31.seconds.ago, updated_at: 1.second.ago)

    @order_2 = create(:order, user: @user_1, status: 'pending')
    create(:order_item, order: @order_2, item: @item_3, unit_price: 17, quantity: 17, fulfilled: true, created_at: 32.seconds.ago, updated_at: 1.second.ago)

    @order_3 = create(:order, user: @user_1, status: 'completed')
    create(:order_item, order: @order_3, item: @item_4, unit_price: 5, quantity: 5, fulfilled: true, created_at: 4.seconds.ago, updated_at: 1.second.ago)
    create(:order_item, order: @order_3, item: @item_5, unit_price: 3, quantity: 3, fulfilled: true, created_at: 30.seconds.ago, updated_at: 29.seconds.ago)
  end

  describe 'extension statistics' do
    before :each do
      @merchant_5 = create(:merchant)
      @merchant_6 = create(:merchant)
      @merchant_7 = create(:merchant)
      @merchant_8 = create(:merchant)
      @merchant_9 = create(:merchant)
      @merchant_10 = create(:merchant)
      @merchant_11 = create(:merchant)
      @merchant_12 = create(:merchant)
      @item_7 = create(:item, user: @merchant_5, quantity: 1000)
      @item_8 = create(:item, user: @merchant_6, quantity: 1000)
      @item_9 = create(:item, user: @merchant_7, quantity: 1007)
      @item_10 = create(:item, user: @merchant_8, quantity: 100)
      @item_11 = create(:item, user: @merchant_9, quantity: 100)
      @item_12 = create(:item, user: @merchant_10, quantity: 100)
      @item_13 = create(:item, user: @merchant_11, quantity: 100)
      @item_14 = create(:item, user: @merchant_12, quantity: 100)
      @order_4 = create(:order, user: @user_2, status: 'completed')
      create(:order_item, order: @order_4, item: @item_7, quantity: 10, unit_price: 2, fulfilled: true, created_at: 40.days.ago, updated_at: 1.day.ago)
      create(:order_item, order: @order_4, item: @item_8, quantity: 11, unit_price: 1, fulfilled: true, created_at: 30.days.ago, updated_at: 1.day.ago)
      create(:order_item, order: @order_4, item: @item_9, quantity: 10, unit_price: 2, fulfilled: true, created_at: 10.days.ago, updated_at: 1.day.ago)
      create(:order_item, order: @order_4, item: @item_14, quantity: 9, unit_price: 2, fulfilled: true, created_at: 14.days.ago, updated_at: 1.day.ago)
      create(:order_item, order: @order_4, item: @item_9, quantity: 5, unit_price: 2, fulfilled: true, created_at: 40.days.ago, updated_at: 1.day.ago)
      create(:order_item, order: @order_4, item: @item_10, quantity: 6, unit_price: 1, fulfilled: true, created_at: 40.days.ago, updated_at: 1.day.ago)
      create(:order_item, order: @order_4, item: @item_1, quantity: 2, unit_price: 1, fulfilled: true, created_at: 40.days.ago, updated_at: 1.day.ago)
      create(:order_item, order: @order_4, item: @item_6, quantity: 3, unit_price: 1, fulfilled: true, created_at: 40.days.ago, updated_at: 1.day.ago)


      @order_5 = create(:order, user: @user_3, status: 'pending')
      create(:order_item, order: @order_5, item: @item_7, quantity: 1, unit_price: 1, fulfilled: true, created_at: 5.days.ago, updated_at: 1.day.ago)
      create(:order_item, order: @order_5, item: @item_8, quantity: 4, unit_price: 1, fulfilled: true, created_at: 6.days.ago, updated_at: 1.day.ago)
      create(:order_item, order: @order_5, item: @item_10, quantity: 22, unit_price: 1, fulfilled: true, created_at: 3.days.ago, updated_at: 1.day.ago)
      create(:order_item, order: @order_5, item: @item_13, quantity: 23, unit_price: 1, fulfilled: true, created_at: 2.days.ago, updated_at: 1.day.ago)

      @order_6 = create(:order, user: @user_4, status: 'completed')
      create(:order_item, order: @order_6, item: @item_11, quantity: 19, unit_price: 1, fulfilled: true, created_at: 4.days.ago, updated_at: 1.day.ago)
      create(:order_item, order: @order_6, item: @item_12, quantity: 9, unit_price: 1, fulfilled: true, created_at: 30.days.ago, updated_at: 29.seconds.ago)
      create(:order_item, order: @order_6, item: @item_13, quantity: 12, unit_price: 1, fulfilled: true, created_at: 30.days.ago, updated_at: 29.seconds.ago)
      create(:order_item, order: @order_6, item: @item_14, quantity: 13, unit_price: 1, fulfilled: true, created_at: 30.days.ago, updated_at: 29.seconds.ago)
      create(:order_item, order: @order_6, item: @item_11, quantity: 14, unit_price: 1, fulfilled: true, created_at: 30.days.ago, updated_at: 29.seconds.ago)

      @order_7 = create(:order, user: @user_5, status: 'cancelled')
      create(:order_item, order: @order_7, item: @item_11, quantity: 1, unit_price: 99999999, fulfilled: false, created_at: 30.days.ago, updated_at: 29.seconds.ago)
      create(:order_item, order: @order_7, item: @item_11, quantity: 1, unit_price: 99999999, fulfilled: false, created_at: 30.minutes.ago, updated_at: 29.seconds.ago)
      create(:order_item, order: @order_7, item: @item_10, quantity: 1, unit_price: 1, fulfilled: true, created_at: 30.minutes.ago, updated_at: 29.seconds.ago)
      create(:order_item, order: @order_7, item: @item_10, quantity: 1, unit_price: 1, fulfilled: true, created_at: 30.days.ago, updated_at: 29.seconds.ago)
      @order_8 = create(:order, user: @user_3, status: 'pending')
      create(:order_item, order: @order_8, item: @item_1, quantity: 1, unit_price: 1, fulfilled: true, created_at: 70.days.ago, updated_at: 1.day.ago)
    end

    describe 'as an admin, merchant or visitor' do
      before :each do
        @admin = create(:admin)
      end

      describe 'I see top ten merchants by items sold this month' do
        it 'as a visitor' do
          visit merchants_path
        end

        it 'as an admin' do
          login_as(@admin)
          visit merchants_path
        end

        it 'as a merchant' do
          login_as(@merchant_1)
          visit merchants_path
        end

        after :each do
          within '#statistics' do
            expect(page).to have_content("Top 10 Merchants who sold the most items this month")
            within '#items-this-month' do
              items_this_month = page.find_all(".list-group-item")
              expect(items_this_month[0]).to have_content(@merchant_1.name)
              expect(items_this_month[1]).to have_content(@merchant_11.name)
              expect(items_this_month[2]).to have_content(@merchant_8.name)
              expect(items_this_month[3]).to have_content(@merchant_2.name)
              expect(items_this_month[4]).to have_content(@merchant_9.name)
              expect(items_this_month[5]).to have_content(@merchant_7.name)
              expect(items_this_month[6]).to have_content(@merchant_12.name)
              expect(items_this_month[7]).to have_content(@merchant_3.name)
              expect(items_this_month[8]).to have_content(@merchant_6.name)
              expect(items_this_month[9]).to have_content(@merchant_4.name)
            end
          end
        end
      end

      describe 'I see top ten merchants by items sold last month' do
        it 'as a visitor' do
          visit merchants_path
        end

        it 'as an admin' do
          login_as(@admin)
          visit merchants_path
        end

        it 'as a merchant' do
          login_as(@merchant_1)
          visit merchants_path
        end

        after :each do
          within '#statistics' do
            expect(page).to have_content("Top 10 Merchants who sold the most items last month")
            within '#items-last-month' do
              items_last_month = page.find_all(".list-group-item")
              expect(items_last_month[0]).to have_content(@merchant_9.name)
              expect(items_last_month[1]).to have_content(@merchant_12.name)
              expect(items_last_month[2]).to have_content(@merchant_11.name)
              expect(items_last_month[3]).to have_content(@merchant_6.name)
              expect(items_last_month[4]).to have_content(@merchant_5.name)
              expect(items_last_month[5]).to have_content(@merchant_10.name)
              expect(items_last_month[6]).to have_content(@merchant_8.name)
              expect(items_last_month[7]).to have_content(@merchant_7.name)
              expect(items_last_month[8]).to have_content(@merchant_2.name)
              expect(items_last_month[9]).to have_content(@merchant_1.name)
            end
          end
        end
      end

      describe 'I see top ten merchants by revenue of fulfilled orders this month' do
        it 'as a visitor' do
          visit merchants_path
        end

        it 'as an admin' do
          login_as(@admin)
          visit merchants_path
        end

        it 'as a merchant' do
          login_as(@merchant_1)
          visit merchants_path
        end

        after :each do
          within '#statistics' do
            expect(page).to have_content("Top 10 Merchants by revenue of fulfilled items this month")
            within '#revenue-this-month' do
              revenue_this_month = page.find_all(".list-group-item")
              expect(revenue_this_month[0]).to have_content(@merchant_1.name)
              expect(revenue_this_month[1]).to have_content(@merchant_2.name)
              expect(revenue_this_month[2]).to have_content(@merchant_3.name)
              expect(revenue_this_month[3]).to have_content(@merchant_11.name)
              expect(revenue_this_month[4]).to have_content(@merchant_8.name)
              expect(revenue_this_month[5]).to have_content(@merchant_7.name)
              expect(revenue_this_month[6]).to have_content(@merchant_9.name)
              expect(revenue_this_month[7]).to have_content(@merchant_12.name)
              expect(revenue_this_month[8]).to have_content(@merchant_4.name)
              expect(revenue_this_month[9]).to have_content(@merchant_6.name)
            end
          end
        end
      end

      describe 'I see top ten merchants by revenue of fulfilled orders last month' do
        it 'as a visitor' do
          visit merchants_path
        end

        it 'as an admin' do
          login_as(@admin)
          visit merchants_path
        end

        it 'as a merchant' do
          login_as(@merchant_1)
          visit merchants_path
        end

        after :each do
          within '#statistics' do
            expect(page).to have_content("Top 10 Merchants by revenue of fulfilled items last month")
            within '#revenue-last-month' do
              revenue_last_month = page.find_all(".list-group-item")
              expect(revenue_last_month[0]).to have_content(@merchant_5.name)
              expect(revenue_last_month[1]).to have_content(@merchant_9.name)
              expect(revenue_last_month[2]).to have_content(@merchant_12.name)
              expect(revenue_last_month[3]).to have_content(@merchant_11.name)
              expect(revenue_last_month[4]).to have_content(@merchant_6.name)
              expect(revenue_last_month[5]).to have_content(@merchant_7.name)
              expect(revenue_last_month[6]).to have_content(@merchant_10.name)
              expect(revenue_last_month[7]).to have_content(@merchant_8.name)
              expect(revenue_last_month[8]).to have_content(@merchant_2.name)
              expect(revenue_last_month[9]).to have_content(@merchant_1.name)
            end
          end
        end
      end

      describe 'I dont see top five merchants by fulfillment speed to my state' do
        it 'as a visitor' do
          visit merchants_path
        end

        it 'as an admin' do
          login_as(@admin)
          visit merchants_path
        end

        it 'as a merchant' do
          login_as(@merchant_1)
          visit merchants_path
        end

        after :each do
          expect(page).to_not have_content("Top 5 Merchants By Fulfillment Speed to")
          expect(page).to_not have_content("'s state")
        end
      end

      describe 'I dont see top five merchants by fulfillment speed to my city' do
        it 'as a visitor' do
          visit merchants_path
        end

        it 'as an admin' do
          login_as(@admin)
          visit merchants_path
        end

        it 'as a merchant' do
          login_as(@merchant_1)
          visit merchants_path
        end

        after :each do
          expect(page).to_not have_content("Top 5 Merchants By Fulfillment Speed to")
          expect(page).to_not have_content("'s city")
        end
      end
    end

    describe 'as a registered user' do
      before :each do
        login_as(@user_3)
      end

      it 'I see top ten merchants by items sold this month' do
        visit merchants_path

        within '#statistics' do
          expect(page).to have_content("Top 10 Merchants who sold the most items this month")
          within '#items-this-month' do
            items_this_month = page.find_all(".list-group-item")
            expect(items_this_month[0]).to have_content(@merchant_1.name)
            expect(items_this_month[1]).to have_content(@merchant_11.name)
            expect(items_this_month[2]).to have_content(@merchant_8.name)
            expect(items_this_month[3]).to have_content(@merchant_2.name)
            expect(items_this_month[4]).to have_content(@merchant_9.name)
            expect(items_this_month[5]).to have_content(@merchant_7.name)
            expect(items_this_month[6]).to have_content(@merchant_12.name)
            expect(items_this_month[7]).to have_content(@merchant_3.name)
            expect(items_this_month[8]).to have_content(@merchant_6.name)
            expect(items_this_month[9]).to have_content(@merchant_4.name)
          end
        end
      end

      it 'I see top ten merchants by items sold last month' do
        visit merchants_path

        within '#statistics' do
          expect(page).to have_content("Top 10 Merchants who sold the most items last month")
          within '#items-last-month' do
            items_last_month = page.find_all(".list-group-item")
            expect(items_last_month[0]).to have_content(@merchant_9.name)
            expect(items_last_month[1]).to have_content(@merchant_12.name)
            expect(items_last_month[2]).to have_content(@merchant_11.name)
            expect(items_last_month[3]).to have_content(@merchant_6.name)
            expect(items_last_month[4]).to have_content(@merchant_5.name)
            expect(items_last_month[5]).to have_content(@merchant_10.name)
            expect(items_last_month[6]).to have_content(@merchant_8.name)
            expect(items_last_month[7]).to have_content(@merchant_7.name)
            expect(items_last_month[8]).to have_content(@merchant_2.name)
            expect(items_last_month[9]).to have_content(@merchant_1.name)
          end
        end
      end

      it 'I see top ten merchants by fulfillment of completed orders this month' do
        visit merchants_path

        within '#statistics' do
          expect(page).to have_content("Top 10 Merchants by revenue of fulfilled items this month")
          within '#revenue-this-month' do
            revenue_this_month = page.find_all(".list-group-item")
            expect(revenue_this_month[0]).to have_content(@merchant_1.name)
            expect(revenue_this_month[1]).to have_content(@merchant_2.name)
            expect(revenue_this_month[2]).to have_content(@merchant_3.name)
            expect(revenue_this_month[3]).to have_content(@merchant_11.name)
            expect(revenue_this_month[4]).to have_content(@merchant_8.name)
            expect(revenue_this_month[5]).to have_content(@merchant_7.name)
            expect(revenue_this_month[6]).to have_content(@merchant_9.name)
            expect(revenue_this_month[7]).to have_content(@merchant_12.name)
            expect(revenue_this_month[8]).to have_content(@merchant_4.name)
            expect(revenue_this_month[9]).to have_content(@merchant_6.name)
          end
        end
      end

      it 'I see top ten merchants by fulfillment of completed orders last month' do
        visit merchants_path

        within '#statistics' do
          expect(page).to have_content("Top 10 Merchants by revenue of fulfilled items last month")
          within '#revenue-last-month' do
            revenue_last_month = page.find_all(".list-group-item")
            expect(revenue_last_month[0]).to have_content(@merchant_5.name)
            expect(revenue_last_month[1]).to have_content(@merchant_9.name)
            expect(revenue_last_month[2]).to have_content(@merchant_12.name)
            expect(revenue_last_month[3]).to have_content(@merchant_11.name)
            expect(revenue_last_month[4]).to have_content(@merchant_6.name)
            expect(revenue_last_month[5]).to have_content(@merchant_7.name)
            expect(revenue_last_month[6]).to have_content(@merchant_10.name)
            expect(revenue_last_month[7]).to have_content(@merchant_8.name)
            expect(revenue_last_month[8]).to have_content(@merchant_2.name)
            expect(revenue_last_month[9]).to have_content(@merchant_1.name)
          end
        end
      end

      it 'I see top five merchants by fulfillment speed to my state' do
        visit merchants_path

        within '#statistics' do
          expect(page).to have_content("Top 5 Merchants By Fulfillment Speed to #{@user_3.name}'s state")
          within '#items-by-state-fulfillment-speed' do
            items_by_state_speed = page.find_all(".list-group-item")
            expect(items_by_state_speed[0]).to have_content(@merchant_8.name)
            expect(items_by_state_speed[1]).to have_content(@merchant_5.name)
            expect(items_by_state_speed[2]).to have_content(@merchant_6.name)
            expect(items_by_state_speed[3]).to have_content(@merchant_11.name)
            expect(items_by_state_speed[4]).to have_content(@merchant_9.name)
          end
        end
      end

      it 'I see top five merchants by fulfillment speed to my city' do
        visit merchants_path

        within '#statistics' do
          expect(page).to have_content("Top 5 Merchants By Fulfillment Speed to #{@user_3.name}'s city")
          within '#items-by-city-fulfillment-speed' do
            items_by_city_speed = page.find_all(".list-group-item")
            expect(items_by_city_speed[0]).to have_content(@merchant_11.name)
            expect(items_by_city_speed[1]).to have_content(@merchant_8.name)
            expect(items_by_city_speed[2]).to have_content(@merchant_5.name)
            expect(items_by_city_speed[3]).to have_content(@merchant_6.name)
            expect(items_by_city_speed[4]).to have_content(@merchant_1.name)
          end
        end
      end
    end
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
          expect(page).to have_content("Registered: #{merchant.created_at.strftime("%B, %d %Y")}")
        end
      end
    end
  end

  context 'in the statistics part of the page' do
    it "I see the top 3 merchants by revenue and their revenue" do
      visit merchants_path

      within '#statistics' do
        within '#biggest-merchants' do
          biggest_merchants = page.find_all(".list-group-item")
          expect(page).to have_content("Top 3 Merchants by revenue")
          expect(biggest_merchants[0]).to have_content("#{@merchant_1.name}. Revenue: $1,300.00")
          expect(biggest_merchants[1]).to have_content("#{@merchant_2.name}. Revenue: $298.00")
          expect(biggest_merchants[2]).to have_content("#{@merchant_3.name}. Revenue: $25.00")
        end
      end
    end

    it "I see the top 3 fastest merchants and their times" do
      visit merchants_path

      within '#statistics' do
        within '#fastest-merchants' do
          fastest_merchants = page.find_all(".list-group-item")
          expect(page).to have_content("Top 3 Fastest Merchants")
          expect(fastest_merchants[0]).to have_content("#{@merchant_4.name}. Average Fulfillment Time: #{time_string("00:00:01")}")
          expect(fastest_merchants[1]).to have_content("#{@merchant_3.name}. Average Fulfillment Time: #{time_string("00:00:03")}")
          expect(fastest_merchants[2]).to have_content("#{@merchant_2.name}. Average Fulfillment Time: #{time_string("00:00:30")}")
        end
      end
    end

    it "I see the top 3 slowest merchants and their times" do
      visit merchants_path

      within '#statistics' do
        within '#slowest-merchants' do
          slowest_merchants = page.find_all(".list-group-item")
          expect(page).to have_content("Top 3 Slowest Merchants")
          expect(slowest_merchants[0]).to have_content("#{@merchant_1.name}. Average Fulfillment Time: #{time_string("00:00:58")}")
          expect(slowest_merchants[1]).to have_content("#{@merchant_2.name}. Average Fulfillment Time: #{time_string("00:00:30")}")
          expect(slowest_merchants[2]).to have_content("#{@merchant_3.name}. Average Fulfillment Time: #{time_string("00:00:03")}")
        end
      end
    end

    it 'I see the top 3 states where orders were shipped and their order count' do
      OrderItem.destroy_all
      Order.destroy_all
      Item.destroy_all
      User.destroy_all


      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      merchant_4 = create(:merchant)

      user_1 = create(:user, state: 'California', city: 'Los Angeles')
      user_2 = create(:user, state: 'Florida', city: 'Wausau')
      user_3 = create(:user, state: 'Wisconsin', city: 'Wausau')
      user_4 = create(:user, state: 'Wisconsin', city: 'Green Bay')
      user_5 = create(:user, state: 'Colorado', city: 'Denver')


      item_1 = create(:item, user: merchant_1, quantity: 100, price: 30)
      create(:item, user: merchant_1, quantity: 100, price: 20)
      create(:item, user: merchant_2, quantity: 100, price: 17)
      create(:item, user: merchant_3, quantity: 100, price: 5)
      create(:item, user: merchant_4, quantity: 100, price: 3)
      create(:item, user: merchant_2, quantity: 100, price: 3)

      # User 1 from LA 4 orders:
      order_1 = create(:order, user: user_1, status: 'completed')
      create(:order_item, order: order_1, item: item_1, fulfilled: true)
      order_2 = create(:order, user: user_1, status: 'completed')
      create(:order_item, order: order_2, item: item_1, fulfilled: true)
      order_3 = create(:order, user: user_1, status: 'completed')
      create(:order_item, order: order_3, item: item_1, fulfilled: true)
      order_4 = create(:order, user: user_1, status: 'completed')
      create(:order_item, order: order_4, item: item_1, fulfilled: true)


      #User 2 from Florida's 3 orders:
      order_5 = create(:order, user: user_2, status: 'completed')
      create(:order_item, order: order_5, item: item_1, fulfilled: true)
      order_6 = create(:order, user: user_2, status: 'completed')
      create(:order_item, order: order_6, item: item_1, fulfilled: true)
      order_7 = create(:order, user: user_2, status: 'completed')
      create(:order_item, order: order_7, item: item_1, fulfilled: true)

      #User 3 from Wisconsin's 2 orders
      order_8 = create(:order, user: user_3, status: 'completed')
      create(:order_item, order: order_8, item: item_1, fulfilled: true)
      order_9 = create(:order, user: user_3, status: 'completed')
      create(:order_item, order: order_9, item: item_1, fulfilled: true)

      #User 4 from Wisconsin's 3 orders
      order_10 = create(:order, user: user_4, status: 'completed')
      create(:order_item, order: order_10, item: item_1, fulfilled: true)
      order_11 = create(:order, user: user_4, status: 'completed')
      create(:order_item, order: order_11, item: item_1, fulfilled: true)
      order_12 = create(:order, user: user_4, status: 'completed')
      create(:order_item, order: order_12, item: item_1, fulfilled: true)

      #User 5, from Colorado's two orders
      order_13 = create(:order, user: user_5, status: 'completed')
      create(:order_item, order: order_13, item: item_1, fulfilled: true)
      order_14 = create(:order, user: user_5, status: 'completed')
      create(:order_item, order: order_14, item: item_1, fulfilled: true)

      visit merchants_path

      within '#statistics' do
        within '#top-states' do
          top_states = page.find_all(".list-group-item")
          expect(top_states[0]).to have_content("Wisconsin. Number of orders: 5")
          expect(top_states[1]).to have_content("California. Number of orders: 4")
          expect(top_states[2]).to have_content("Florida. Number of orders: 3")
        end
      end
    end

    it 'I see the top 3 cities where orders were shipped and their order count' do
      additional_order_for_la = create(:order, user: @user_1, status: 'completed')
      additional_order_for_la_2 = create(:order, user: @user_1, status: 'completed')
      additional_order_for_la_3 = create(:order, user: @user_1, status: 'completed')
      order_for_green_bay = create(:order, user: @user_4, status: 'completed')
      create(:order, user: @user_4, status: 'completed')
      create(:order, user: @user_4, status: 'completed')
      create(:order, user: @user_4, status: 'completed')
      create(:order, user: @user_2, status: 'completed')
      create(:order, user: @user_2, status: 'completed')
      create(:order, user: @user_2, status: 'completed')
      create(:order_item, order: additional_order_for_la, item: @item_1, fulfilled: true)
      create(:order_item, order: additional_order_for_la_2, item: @item_1, fulfilled: true)
      create(:order_item, order: additional_order_for_la_3, item: @item_1, fulfilled: true)
      create(:order_item, order: order_for_green_bay, item: @item_1, fulfilled: true)


      visit merchants_path

      within '#statistics' do
        within '#top-cities' do
          top_cities = page.find_all(".list-group-item")
          expect(top_cities[0]).to have_content("Los Angeles, California. Number of orders: 5")
          expect(top_cities[1]).to have_content("Green Bay, Wisconsin. Number of orders: 4")
          expect(top_cities[2]).to have_content("Wausau, Florida. Number of orders: 3")
        end
      end
    end

    it 'I see the top 3 biggest orders and the order count' do

      OrderItem.destroy_all
      Order.destroy_all

      order_1 = create(:order, user: @user_1, status: 'completed')
      create(:order_item, order: order_1, item: @item_1, fulfilled: true, quantity: 100)
      order_2 = create(:order, user: @user_1, status: 'completed')
      create(:order_item, order: order_2, item: @item_1, fulfilled: true, quantity: 8)
      order_3 = create(:order, user: @user_1, status: 'completed')
      create(:order_item, order: order_3, item: @item_1, fulfilled: true, quantity: 5)
      order_4 = create(:order, user: @user_1, status: 'completed')
      create(:order_item, order: order_4, item: @item_1, fulfilled: true, quantity: 2)

      visit merchants_path


      within '#statistics' do
        within '#biggest-orders' do
          biggest_orders = page.find_all(".list-group-item")
          expect(biggest_orders[0]).to have_content("Order: #{order_1.id} Quantity: 10")
          expect(biggest_orders[1]).to have_content("Order: #{order_2.id} Quantity: 8")
          expect(biggest_orders[2]).to have_content("Order: #{order_3.id} Quantity: 5")
        end
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
