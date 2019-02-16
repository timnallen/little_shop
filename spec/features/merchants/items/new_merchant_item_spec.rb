require 'rails_helper'

RSpec.describe 'adding a new item' do
  context 'as a merchant' do
    before :each do
      @merchant = create(:merchant)
      @valid_item = build(:item)
      @invalid_item = build(:item)
    end

    it 'I can add a new item to the system' do
      login_as(@merchant)

      visit dashboard_items_path

      click_link 'Add a new item'

      expect(current_path).to eq(new_dashboard_item_path)

      fill_in :Name, with: @valid_item.name
      fill_in :Description, with: @valid_item.description
      fill_in :Image, with: @valid_item.image
      fill_in :Price, with: @valid_item.price
      fill_in :Quantity, with: @valid_item.quantity

      click_button 'Submit'

      expect(current_path).to eq(dashboard_items_path)

      expect(page).to have_content("You have added a new item.")

      within "#item-#{Item.last.id}" do
        expect(page).to have_content(@valid_item.name)
        expect(page).to have_content(@valid_item.description)
        expect(page).to have_content(@valid_item.price)
        expect(page).to have_content(@valid_item.quantity)
        expect(page).to have_css("img[src='#{@valid_item.image}']")
      end
    end

    it 'A placeholder image is used if no image is provided' do
      visit new_dashboard_item_path

      fill_in :Name, with: @valid_item.name
      fill_in :Description, with: @valid_item.description
      fill_in :Price, with: @valid_item.price
      fill_in :Quantity, with: @valid_item.quantity

      click_button 'Submit'

      expect(current_path).to eq(dashboard_items_path)

      expect(page).to have_content("You have added a new item.")

      within "#item-#{Item.last.id}" do
        expect(page).to have_content(@valid_item.name)
        expect(page).to have_content(@valid_item.description)
        expect(page).to have_content(@valid_item.price)
        expect(page).to have_content(@valid_item.quantity)
        expect(page).to have_css("img[src='via.placeholder.com/?text=LittleShop]")
      end
    end
  end
end
