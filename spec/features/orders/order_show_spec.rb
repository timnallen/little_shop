require 'rails_helper'

RSpec.describe 'order show page', type: :feature do
  describe 'as a registered user' do
    before :each do
      @user = create(:user)
      @item_1 = create(:item)
      @item_2 = create(:item)
      @order = create(:order, user: @user)
      create(:order_item, order: @order, item: @item_1)
      create(:order_item, order: @order, item: @item_2)

      login_as(@user)
    end

    it 'shows me a link to the order show page on my orders index' do
      visit profile_orders_path

      click_on "#{@order.id}"

      expect(current_path).to eq(profile_order_path(@order))
    end
  end

  describe 'as a visitor' do
  end
end

# And I click on a link for order's show page
# My URL route is now something like "/profile/orders/15"
# I see all information about the order, including the following information:
# - the ID of the order
# - the date the order was made
# - the date the order was last updated
# - the current status of the order
# - each item I ordered, including name, description, thumbnail, quantity, price and subtotal
# - the total quantity of items in the whole order
# - the grand total of all items for that order
