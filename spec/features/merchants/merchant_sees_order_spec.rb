require 'rails_helper'

RSpec.describe "When I visit an order show page from my dashboard" do
  before :each do
    @merchant = create(:merchant)
    @customer = create(:user, address: "123 Main St", city: "Denver", state: "CO", zipcode: 80302)
    @other_merchant = create(:merchant)
    @item_1 = create(:item, user: @merchant)
    @item_2 = create(:item, user: @merchant)
    @item_3 = create(:item, user: @merchant)
    @item_4 = create(:item, user: @merchant)
    @item_5 = create(:item, user: @other_merchant)
    @item_6 = create(:item, user: @other_merchant)
    @item_7 = create(:item, user: @other_merchant)
    @order_1 = create(:order, user: @user_1, status: 'pending')
    @order_item_1 = create(:order_item, order: @order_1, item: @item_1, quantity: 9)
    @order_item_2 = create(:order_item, order: @order_1, item: @item_2, quantity: 2)
    @order_item_3 = create(:order_item, order: @order_1, item: @item_3, quantity: 7)
    @order_item_4 = create(:order_item, order: @order_1, item: @item_4, quantity: 4)
    @order_item_5 = create(:order_item, order: @order_1, item: @item_5, quantity: 5)
    @order_item_6 = create(:order_item, order: @order_1, item: @item_6, quantity: 6)
    @order_item_7 = create(:order_item, order: @order_1, item: @item_7, quantity: 7)

  end

  context "as a merchant" do

    it "I see customer/s name, address" do
      login_as(@merchant)
      visit dashboard_path

      expect(page).to have_content("Customer: #{@customer.name}")
      expect(page).to have_content("Address: #{@customer.address}")
      expect(page).to have_content(@customer.city)
      expect(page).to have_content(@customer.state)
      expect(page).to have_content(@customer.zipcode)

    end

    it "I do not see items being purchased from other merchants" do
      login_as(@merchant)
      visit dashboard_path

      expect(page).to_not have_content(@item_5.name)
      expect(page).to_not have_content(@item_6.name)
      expect(page).to_not have_content(@item_7.name)
    end

    it "I see items that are being purchased from me" do
      login_as(@merchant)
      visit dashboard_path

      expect(page).to have_link(@item_1.name)
      expect(page).to have_link(@item_2.name)
      expect(page).to have_link(@item_3.name)
      expect(page).to have_link(@item_4.name)

      click_link(@item_1.name)
      expect(current_path).to eq(item_path(@item_1))

      visit dashboard_path
      click_link(@item_2.name)
      expect(current_path).to eq(item_path(@item_2))

      visit dashboard_path
      click_link(@item_3.name)
      expect(current_path).to eq(item_path(@item_3))

      visit dashboard_path
      click_link(@item_4.name)
      expect(current_path).to eq(item_path(@item_4))
    end


    it "each item has an image, price and quantity"  do
      login_as(@merchant)
      visit dashboard_path

      within("#item-#{@item_1.id}") do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.image)
        expect(page).to have_content(@item_1.price)
        expect(page).to have_content("Quantity: 9")
      end

      within("#item-#{@item_2.id}") do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_2.image)
        expect(page).to have_content(@item_2.price)
        expect(page).to have_content("Quantity: 2")
      end

      within("#item-#{@item_3.id}") do
        expect(page).to have_content(@item_3.name)
        expect(page).to have_content(@item_3.image)
        expect(page).to have_content(@item_3.price)
        expect(page).to have_content("Quantity: 7")
      end

      within("#item-#{@item_4.id}") do
        expect(page).to have_content(@item_4.name)
        expect(page).to have_content(@item_4.image)
        expect(page).to have_content(@item_4.price)
        expect(page).to have_content("Quantity: 4")
      end
    end

  end

end
