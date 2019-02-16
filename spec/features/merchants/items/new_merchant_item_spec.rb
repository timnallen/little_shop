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

      expect(current_path).to eq(new_merchant_item_path)

      fill_in :name, with: @valid_item.name
      fill_in :description, with: @valid_item.description
      fill_in :image, with: @valid_item.image
      fill_in :price, with: @valid_item.price
      fill_in :quantity, with: @valid_item.quantity

      click_button 'Submit'

      expect(current_path).to eq(dashboard_items_path)

      within "#item-#{Item.last.id}" do
        expect(page).to have_content(@valid_item.name)
        expect(page).to have_content(@valid_item.description)
        expect(page).to have_content(@valid_item.price)
        expect(page).to have_content(@valid_item.quantity)
        expect(page).to have_css("img[src=#{@valid_item.image}]")
      end
    end
  end
end
