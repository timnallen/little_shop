require 'rails_helper'

RSpec.describe 'admin views order show' do
  describe 'as an admin when Im on a users profile page and I click on an order' do
    before :each do
      @user = create(:user)
      @order = create(:order, user: @user)
      merchant = create(:merchant)
      item_1 = create(:item, user: merchant)
      item_2 = create(:item, user: merchant)
      order_item_1 = create(:order_item, item: item_1, order: @order)
      order_item_2 = create(:order_item, item: item_2, order: @order)
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end

    it 'takes me to the route admin/orders/:id' do
      visit admin_user_path(@user)

      click_on "See #{@user.name}'s Orders"

      click_on "#{@order.id}"

      expect(current_path).to eq(admin_order_path(@order))
    end
    #
    # it 'shows me all the information about the order' do
    #   visit admin_order_path(@order)
    #
    #
    # end
  end
end
# I see all information about the order, including the following information:
# - the ID of the order
# - the date the order was made
# - the date the order was last updated
# - the current status of the order
# - each item the user ordered, including name, description, thumbnail, quantity, price and subtotal
# - the total quantity of items in the whole order
# - the grand total of all items for that order
