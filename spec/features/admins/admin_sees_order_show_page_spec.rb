require 'rails_helper'

RSpec.describe 'admin views order show' do
  before :each do
    @user = create(:user)
    @order = create(:order, user: @user)
    @merchant = create(:merchant)
    @item_1 = create(:item, user: @merchant, quantity: 11)
    @item_2 = create(:item, user: @merchant, quantity: 1)
    @order_item_1 = create(:order_item, item: @item_1, order: @order, quantity: 9)
    @order_item_2 = create(:order_item, item: @item_2, order: @order, quantity: 3)
    @incomplete_order = create(:order, user: @user, status: 0)
    @incomplete_order_item_1 = create(:order_item, order: @incomplete_order, item: @item_1, unit_price: @item_1.price, quantity: 1)
    @incomplete_order_item_2 = create(:order_item, order: @incomplete_order, item: @item_2, unit_price: @item_2.price, fulfilled: true)

    admin = create(:admin)

    login_as(admin)
  end
  describe 'as an admin when Im on a users profile page and I click on an order' do
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

  describe 'I can cancel pending and processing orders' do
    it 'Changes the order status to cancelled' do
      visit admin_order_path(@incomplete_order)

      click_button "Cancel Order"

      expect(current_path).to eq(admin_user_path(@user))
      expect(page).to have_content("Order ##{@incomplete_order.id} has been cancelled.")
    end

    it 'Cancelled and completed orders do not display an option to cancel them' do
      @incomplete_order.cancel
      @order.update(status: 'completed')
      visit admin_order_path(@incomplete_order)

      expect(page).to_not have_button("Cancel Order")

      visit admin_order_path(@order)
      expect(page).to_not have_button("Cancel Order")
    end

    it 'Changes all order_items status to unfulfilled and retuns the items to the merchant' do
      visit profile_order_path(@incomplete_order)

      click_button "Cancel Order"

      expect(OrderItem.find(@incomplete_order_item_2.id).fulfilled).to eq(false)
      expect(Item.find(@item_1.id).quantity).to eq(@item_1.quantity)
      expect(Item.find(@item_2.id).quantity).to eq(@item_2.quantity + @incomplete_order_item_2.quantity)
    end
  end

  context 'as an admin' do
    context 'when I visit a merchant\'s order show page' do
      it 'I can fulfill an unfulfilled item in that order' do
        visit merchants_path
        click_link("#{@merchant.name}")

        click_on "#{@order.id}"

        expect(current_path).to eq(admin_order_path(@order))

        expect(Item.find(@item_1.id).quantity).to eq(11)

        within "#item-#{@item_1.id}" do
          click_button "Fulfill"
        end

        expect(current_path).to eq(admin_order_path(@order))

        within "#item-#{@item_1.id}" do
          expect(page).to_not have_button("Fulfill")
          expect(page).to have_content("Item Fulfilled")
        end

        expect(Item.find(@item_1.id).quantity).to eq(2)

        expect(page).to have_content("You have fulfilled #{@item_1.name} from order ##{@order.id}")
      end

      it 'doesnt allow me to to fulfill an unfulfilled item if I dont have enough inventory' do
        visit admin_merchant_path(@merchant)

        click_on "#{@order.id}"

        expect(current_path).to eq(admin_order_path(@order))

        expect(Item.find(@item_2.id).quantity).to eq(1)

        within "#item-#{@item_2.id}" do
          expect(page).to_not have_button("Fulfill")
          expect(page).to have_content("Not Enough In Stock")
        end
      end

      it 'changes the order status to complete, if I fulfill the last unfulfilled item in that order' do
        visit admin_merchant_path(@merchant)

        click_link "#{@incomplete_order.id}"

        expect(@incomplete_order.status).to eq("pending")

        expect(current_path).to eq(admin_order_path(@incomplete_order))

        within "#item-#{@item_1.id}" do
          click_button "Fulfill"
        end

        expect(Order.find(@incomplete_order.id).status).to eq("completed")
      end
    end
  end
end
