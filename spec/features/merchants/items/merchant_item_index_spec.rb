require 'rails_helper'

include ActionView::Helpers::NumberHelper

RSpec.describe 'when I visit /merchants/items' do
  context 'as a merchant' do
    before :each do
      @merchant = create(:merchant)
      @merchant.items = create_list(:item, 4)
      @enabled_items = @merchant.items
      @merchant.items << create(:inactive_item)
      @disabled_item = @merchant.items.last
    end
    it 'I see a link to add a new item' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
      visit dashboard_items_path

      expect(page).to have_link("Add a new item")
    end

    it 'I see each item I have already added to the system' do
      other_merchant_item = create(:item)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
      visit dashboard_items_path


      @merchant.items.each do |item|
        within "#item-#{item.id}" do
          expect(page).to have_content("Item ##{item.id}")
          expect(page).to have_content(item.name)
          expect(page).to have_css("img[src*='#{item.image}']")
          expect(page).to have_content("Price: #{number_to_currency(item.price)}")
          expect(page).to have_content("Current Stock: #{item.quantity}")
        end
      end
      expect(page).to_not have_css("#item-#{other_merchant_item.id}")
    end

    it 'I see a link to edit each of my items' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
      visit dashboard_items_path

      @merchant.items.each do |item|
        within "#item-#{item.id}" do
          expect(page).to have_link("Edit Item")
        end
      end
    end

    it 'I see a button to delete an unordered item' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
      visit dashboard_items_path

      within "#item-#{@enabled_items.first.id}" do
        expect(page).to have_button("Delete Item")
      end
    end

    it 'I see a button to disable an enabled and ordered item' do
      enabled_ordered_item = create(:order_item)
      enabled_ordered_item.update(item: @enabled_items.first)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

      visit dashboard_items_path

      within "#item-#{@enabled_items.first.id}" do
        expect(page).to have_button("Disable Item")
      end
    end

    it 'I see a button to enable a disabled and ordered item' do
      disabled_ordered_item = create(:order_item)
      disabled_ordered_item.update(item: @disabled_item)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

      visit dashboard_items_path

      within "#item-#{@disabled_item.id}" do
        expect(page).to have_button("Enable Item")
      end
    end

    it 'clicking enable on a disabled item enables it' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
      disabled_ordered_item = create(:order_item)
      disabled_ordered_item.update(item: @disabled_item)

      visit dashboard_items_path

      within "#item-#{@disabled_item.id}" do
        click_button 'Enable'
      end

      expect(page).to have_content("Item ##{@disabled_item.id} is now available for sale.")

      within "#item-#{@disabled_item.id}" do
        expect(page).to have_button("Disable")
      end
    end

    it 'clicking disable on an enabled item disables it' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
      enabled_ordered_item = create(:order_item)
      enabled_ordered_item.update(item: @enabled_items.first)

      visit dashboard_items_path

      within "#item-#{@enabled_items.first.id}" do
        click_button 'Disable'
      end

      expect(page).to have_content("Item ##{@enabled_items.first.id} is no longer available for sale.")

      within "#item-#{@enabled_items.first.id}" do
        expect(page).to have_button("Enable")
      end
    end

    it 'clicking delete on an unordered item removes it from the system' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

      visit dashboard_items_path

      within "#item-#{@enabled_items.first.id}" do
        click_button 'Delete'
      end

      expect(page).to have_content("Item ##{@enabled_items.first.id} has been deleted.")
    end
  end
end
