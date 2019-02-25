require 'rails_helper'

RSpec.describe 'order show page', type: :feature do
  describe 'as a registered user' do
    before :each do
      @user = create(:user)
      @item_1 = create(:item)
      @item_2 = create(:item)
      @order = create(:order, user: @user)
      @incomplete_order = create(:order, user: @user, status: 0)
      @incomplete_order_item_1 = create(:order_item, order: @incomplete_order, item: @item_1, unit_price: @item_1.price)
      @incomplete_order_item_2 = create(:order_item, order: @incomplete_order, item: @item_2, unit_price: @item_2.price, fulfilled: true)
      @order_item_1 = create(:order_item, order: @order, item: @item_1, unit_price: @item_1.price)
      @order_item_2 = create(:order_item, order: @order, item: @item_2, unit_price: @item_2.price)

      login_as(@user)
    end

    describe 'reviews ext' do
      it 'shows me a button to add a review' do
        visit profile_order_path(@order)

        within "#item-#{@item_2.id}" do
          expect(page).to have_button("Add Review")
        end

        within "#item-#{@item_1.id}" do
          expect(page).to have_button("Add Review")
          click_button("Add Review")
        end

        expect(current_path).to eq(new_item_review_path(@item_1))

        expect(page).to have_field("Title")
        expect(page).to have_field("Description")
        expect(page).to have_field("Rating")

        fill_in 'review[title]', with: 'Loved this item'
        fill_in 'review[description]', with: 'Best item I ever purchased'
        fill_in 'review[rating]', with: '5'
        click_button 'Submit'

        expect(current_path).to eq(item_path(@item_1))

        within '#reviews' do
          expect(page).to have_content("Loved this item")
          expect(page).to have_content(@user.name)
          expect(page).to have_content("Best item I ever purchased")
          expect(page).to have_content("Rating: 5")
          expect(page).to have_content("Created At: #{Date.today}")
        end
      end

      it 'wont let me add a review with empty fields' do
        visit profile_order_path(@order)

        within "#item-#{@item_1.id}" do
          click_button("Add Review")
        end

        click_button 'Submit'

        expect(page).to have_content("You are missing required fields.")
        expect(page).to have_content("Rating is not a number")
        expect(page).to have_content("Rating can't be blank")
        expect(page).to have_content("Description can't be blank")
        expect(page).to have_content("Title can't be blank")
        expect(page).to have_field("Title")
        expect(page).to have_field("Description")
        expect(page).to have_field("Rating")
      end
    end

    it 'shows me a link to the order show page on my orders index' do
      visit profile_orders_path

      click_on "#{@order.id}"

      expect(current_path).to eq(profile_order_path(@order))
    end

    it 'shows me all information about the order' do
      visit profile_order_path(@order)

      expect(page).to have_content(@order.id)
      expect(page).to have_content(@order.created_at.localtime.strftime("%B, %d %Y at %I:%M %p"))
      expect(page).to have_content(@order.updated_at.localtime.strftime("%B, %d %Y at %I:%M %p"))
      expect(page).to have_content(@order.status.capitalize)

      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.description)
        expect(page).to have_css("img[src='#{@item_1.image}']")
        expect(page).to have_content(@order_item_1.quantity)
        expect(page).to have_content(number_to_currency(@order_item_1.unit_price))
        expect(page).to have_content(number_to_currency(@order_item_1.subtotal))
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_2.description)
        expect(page).to have_css("img[src='#{@item_2.image}']")
        expect(page).to have_content(@order_item_2.quantity)
        expect(page).to have_content(number_to_currency(@order_item_2.unit_price))
        expect(page).to have_content(number_to_currency(@order_item_2.subtotal))
      end

      expect(page).to have_content(@order.quantity_of_items)
      expect(page).to have_content(number_to_currency(@order.grand_total))
    end

    describe 'I can cancel pending and processing orders' do
      it 'Changes the order status to cancelled' do
        visit profile_order_path(@incomplete_order)

        click_button "Cancel Order"

        expect(current_path).to eq(profile_path)
        expect(page).to have_content("Order ##{@incomplete_order.id} has been cancelled.")
      end

      it 'Cancelled and completed orders do not display an option to cancel them' do
        @incomplete_order.cancel
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
  end

  describe 'as a visitor' do
    it 'shows me a 404 if I try to route here' do
      user = create(:user)
      order = create(:order, user: user)

      visit profile_order_path(order)

      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end

  describe 'as an admin' do
    before :each do
      @admin = create(:admin)
      @user = create(:user)
      @item_1 = create(:item)
      @item_2 = create(:item)
      @order = create(:order, user: @user)
      @order_item_1 = create(:order_item, order: @order, item: @item_1)
      @order_item_2 = create(:order_item, order: @order, item: @item_2)

      login_as(@admin)
    end

    it 'shows me the same info as the user' do
      visit profile_order_path(@order)

      expect(page).to have_content(@order.id)
      expect(page).to have_content(@order.created_at.localtime.strftime("%B, %d %Y at %I:%M %p"))
      expect(page).to have_content(@order.updated_at.localtime.strftime("%B, %d %Y at %I:%M %p"))
      expect(page).to have_content(@order.status.capitalize)

      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.description)
        expect(page).to have_css("img[src='#{@item_1.image}']")
        expect(page).to have_content(@order_item_1.quantity)
        expect(page).to have_content(number_to_currency(@order_item_1.unit_price))
        expect(page).to have_content(number_to_currency(@order_item_1.subtotal))
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_2.description)
        expect(page).to have_css("img[src='#{@item_2.image}']")
        expect(page).to have_content(@order_item_2.quantity)
        expect(page).to have_content(number_to_currency(@order_item_2.unit_price))
        expect(page).to have_content(number_to_currency(@order_item_2.subtotal))
      end

      expect(page).to have_content(@order.quantity_of_items)
      expect(page).to have_content(number_to_currency(@order.grand_total))
    end
  end
end
