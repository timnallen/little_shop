require 'rails_helper'

RSpec.describe 'admin views order show' do
  describe 'as an admin when Im on a users profile page and I click on an order' do
    before :each do
      @user = create(:user)
      @order = create(:order, user: @user)
      @merchant = create(:merchant)
      @item_1 = create(:item, user: @merchant)
      @item_2 = create(:item, user: @merchant)
      @order_item_1 = create(:order_item, item: @item_1, order: @order)
      @order_item_2 = create(:order_item, item: @item_2, order: @order)

      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end

    it 'takes me to the route admin/orders/:id' do
      visit admin_user_path(@user)

      click_on "See #{@user.name}'s Orders"

      click_on "#{@order.id}"

      expect(current_path).to eq(admin_order_path(@order))
    end

    it 'shows me all the information about the order' do
      visit admin_order_path(@order)

      expect(page).to have_content(@order.id)
      expect(page).to have_content(@order.created_at)
      expect(page).to have_content(@order.updated_at)
      expect(page).to have_content(@order.status)

      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.description)
        expect(page).to have_content(@item_1.image)
        expect(page).to have_content(@order_item_1.quantity)
        expect(page).to have_content(@order_item_1.unit_price)
        expect(page).to have_content(@order_item_1.subtotal)
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_2.description)
        expect(page).to have_content(@item_2.image)
        expect(page).to have_content(@order_item_2.quantity)
        expect(page).to have_content(@order_item_2.unit_price)
        expect(page).to have_content(@order_item_2.subtotal)
      end

      expect(page).to have_content(@order.quantity_of_items)
      expect(page).to have_content(@order.grand_total)
    end
  end
end
