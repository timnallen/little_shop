require 'rails_helper'

RSpec.describe 'Editing an item' do
  context 'as a merchant' do
    before :each do
      @merchant = create(:merchant)
      @item = create(:item)
      @merchant.items << @item
      login_as(@merchant)

      visit dashboard_items_path
    end

    it 'I can edit an item from my items index' do
      within "#item-#{@item.id}" do
        click_link 'Edit Item'
      end

      fill_in :Name, with: 'New Name'
      click_button :Submit

      within "#item-#{@item.id}" do
        expect(page).to have_content('New Name')
      end
    end

    describe 'I am unable to edit an item when' do
      before :each do
        visit edit_merchant_item_path(@item)
        fill_in :Name, with: @item.name
        fill_in :Description, with: @item.description
        fill_in :Quantity, with: @item.quantity
        fill_in :Price, with: @item.price
      end

      it "I remove the name" do
        fill_in :Name, with: ""
        click_button :Submit
        expect(page).to have_content("There are problems with the provided information.")
        expect(page).to have_content("Name can't be blank")
      end

      it "I remove the description" do
        fill_in :Description, with: ""
        click_button :Submit
        expect(page).to have_content("There are problems with the provided information.")
        expect(page).to have_content("Description can't be blank")
      end

      it "I remove the price" do
        fill_in :Price, with: ""
        click_button 'Submit'
        expect(page).to have_content("There are problems with the provided information.")
        expect(page).to have_content("Price can't be blank")
      end

      it "I try and enter a negative value for the price" do
        fill_in :Price, with: "-999.99"
        click_button 'Submit'
        expect(page).to have_content("There are problems with the provided information.")
        expect(page).to have_content("Price must be greater than or equal to 0")
      end

      it "I remove the quantity" do
        fill_in :Quantity, with: ""
        click_button 'Submit'
        expect(page).to have_content("There are problems with the provided information.")
        expect(page).to have_content("Quantity can't be blank")
      end

      it "I enter a quantity below zero" do
        fill_in :Quantity, with: "-990"
        click_button 'Submit'
        expect(page).to have_content("There are problems with the provided information.")
        expect(page).to have_content("Quantity must be greater than or equal to 0")
      end
    end
  end
end
