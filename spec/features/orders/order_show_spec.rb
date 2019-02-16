require 'rails_helper'

RSpec.describe 'order show page', type: :feature do
  describe 'as a registered user' do
    before :each do
      @user = create(:user)
      @item_1 = create(:item)
      @item_2 = create(:item)
      @order = create(:order, user: @user)
      @order_item_1 = create(:order_item, order: @order, item: @item_1)
      @order_item_2 = create(:order_item, order: @order, item: @item_2)

      login_as(@user)
    end

    it 'shows me a link to the order show page on my orders index' do
      visit profile_orders_path

      click_on "#{@order.id}"

      expect(current_path).to eq(profile_order_path(@order))
    end

    it 'shows me all information about the order' do
      visit profile_order_path(@order)

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

  describe 'as a visitor' do
  end
end
