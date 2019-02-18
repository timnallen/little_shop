require 'rails_helper'

RSpec.describe "When I visit an order show page from my dashboard" do
  before :each do
    @merchant = create(:merchant)
    @customer = create(:user, address: "123 Main St", city: "Denver", state: "CO", zipcode: 80302)
    @other_merchant = create(:merchant)
    @item_1 = create(:item, user: @merchant, price: 24.0, quantity: 11)
    @item_2 = create(:item, user: @merchant, quantity: 1)
    @item_3 = create(:item, user: @merchant)
    @item_4 = create(:item, user: @merchant)
    @item_5 = create(:item, user: @other_merchant)
    @item_6 = create(:item, user: @other_merchant)
    @item_7 = create(:item, user: @other_merchant)
    @order_1 = create(:order, user: @customer, status: 'pending')
    @order_2 = create(:order, user: @customer, status: 'completed')
    @order_item_1 = create(:order_item, order: @order_1, item: @item_1, quantity: 9)
    @order_item_2 = create(:order_item, order: @order_1, item: @item_2, quantity: 2)
    @order_item_3 = create(:order_item, order: @order_1, item: @item_3, quantity: 7)
    @order_item_4 = create(:order_item, order: @order_1, item: @item_4, quantity: 4)
    @order_item_5 = create(:order_item, order: @order_1, item: @item_5, quantity: 5)
    @order_item_6 = create(:order_item, order: @order_1, item: @item_6, quantity: 6)
    @order_item_7 = create(:order_item, order: @order_1, item: @item_7, quantity: 7)
    @order_item_8 = create(:order_item, order: @order_2, item: @item_1, quantity: 5, fulfilled: true)

  end

  context "as a merchant" do
    it "I see customer/s name, address" do
      login_as(@merchant)
      visit dashboard_path
      click_link(@order_1.id)
      expect(current_path).to eq(merchant_order_path(@order_1))

      expect(page).to have_content("Customer: #{@customer.name}")
      expect(page).to have_content("Address: #{@customer.address}")
      expect(page).to have_content(@customer.city)
      expect(page).to have_content(@customer.state)
      expect(page).to have_content(@customer.zipcode)

    end

    it "I do not see items being purchased from other merchants" do
      login_as(@merchant)
      visit dashboard_path
      click_link(@order_1.id)

      expect(page).to_not have_content(@item_5.name)
      expect(page).to_not have_content(@item_6.name)
      expect(page).to_not have_content(@item_7.name)
    end

    it "I see items that are being purchased from me" do
      login_as(@merchant)
      visit dashboard_path
      click_link @order_1.id

      expect(page).to have_link(@item_1.name)
      expect(page).to have_link(@item_2.name)
      expect(page).to have_link(@item_3.name)
      expect(page).to have_link(@item_4.name)


      click_link(@item_1.name)
      expect(current_path).to eq(item_path(@item_1))

      visit dashboard_path
      click_link @order_1.id
      click_link(@item_2.name)
      expect(current_path).to eq(item_path(@item_2))

      visit dashboard_path
      click_link @order_1.id
      click_link(@item_3.name)
      expect(current_path).to eq(item_path(@item_3))
      expect(page).to have_content("This item has not been fulfilled")

      visit dashboard_path
      click_link @order_1.id
      click_link(@item_4.name)
      expect(current_path).to eq(item_path(@item_4))
    end


    it "each item has an image, price and quantity"  do
      login_as(@merchant)
      visit dashboard_path
      click_link @order_1.id

      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_css("img[src*='#{@item_1.image}']")
        expect(page).to have_content("$24.00")
        expect(page).to have_content(@order_item_1.quantity)
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_css("img[src*='#{@item_2.image}']")
        expect(page).to have_content(@item_2.price)
        expect(page).to have_content("Quantity: 2")
      end

      within "#item-#{@item_3.id}" do
        expect(page).to have_content(@item_3.name)
        expect(page).to have_css("img[src*='#{@item_3.image}']")
        expect(page).to have_content(@order_item_3.unit_price)
        expect(page).to have_content("Quantity: 7")
      end

      within "#item-#{@item_4.id}" do
        expect(page).to have_content(@item_4.name)
        expect(page).to have_css("img[src*='#{@item_4.image}']")
        expect(page).to have_content(@item_4.price)
        expect(page).to have_content("Quantity: 4")
      end
    end

    describe 'when I visit an order show page from my dashboard' do
      it 'allows me to to fulfill an unfulfilled item in that order' do
        login_as(@merchant)

        visit dashboard_path

        click_on "#{@order_1.id}"

        expect(current_path).to eq(merchant_order_path(@order_1))

        expect(Item.find(@item_1.id).quantity).to eq(11)

        within "#item-#{@item_1.id}" do
          click_button "Fulfill"
        end

        expect(current_path).to eq(merchant_order_path(@order_1))

        within "#item-#{@item_1.id}" do
          expect(page).to_not have_button("Fulfill")
          expect(page).to have_content("Item Fulfilled")
        end

        expect(Item.find(@item_1.id).quantity).to eq(2)

        expect(page).to have_content("You have fulfilled #{@item_1.name} from order ##{@order_1.id}")
      end

      it 'doesnt allow me to to fulfill an unfulfilled item if I dont have enough inventory' do
        login_as(@merchant)

        visit dashboard_path

        click_on "#{@order_1.id}"

        expect(current_path).to eq(merchant_order_path(@order_1))

        expect(Item.find(@item_2.id).quantity).to eq(1)

        within "#item-#{@item_2.id}" do
          expect(page).to_not have_button("Fulfill")
          expect(page).to have_content("Not Enough In Stock")
        end
      end
    end
  end
end
