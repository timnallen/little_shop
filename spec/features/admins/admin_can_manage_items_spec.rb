require 'rails_helper'

RSpec.describe 'Managing items' do
  context 'as an administrator' do
    before :each do
      @merchant = create(:merchant)
      @item = create(:item)
      @merchant.items << @item
      @new_item = build(:item)

      @admin = create(:admin)
      login_as(@admin)
      visit admin_merchant_items_path(@merchant)
    end

    it 'I can create new items' do
      click_link 'Add a new item'

      fill_in :Name, with: @new_item.name
      fill_in :Description, with: @new_item.description
      fill_in :Price, with: @new_item.price
      fill_in :Quantity, with: @new_item.quantity

      click_button :Submit

      expect(current_path).to eq(admin_merchant_items_path(@merchant))
      expect(page).to have_content("You have added an item")

      within "#item-#{@merchant.items.last.id}" do
        expect(page).to have_content(@new_item.name)
        expect(page).to have_content(@new_item.description)
        expect(page).to have_content(@new_item.price)
        expect(page).to have_content(@new_item.quantity)
        expect(page).to have_link('Edit Item')
        expect(page).to have_button('Disable Item')
      end
    end

    describe 'I am unable to create items with invalid information' do
      before :each do
        visit new_admin_merchant_item_path(@merchant)

        fill_in :Name, with: @new_item.name
        fill_in :Description, with: @new_item.description
        fill_in :Price, with: @new_item.price
        fill_in :Quantity, with: @new_item.quantity
      end

      it "when missing a name" do
        fill_in :Name, with: ""
        click_button 'Submit'
        expect(page).to have_content("There are problems with the provided information.")
        expect(page).to have_content("Name can't be blank")
      end

      it "when missing a description" do
        fill_in :Description, with: ""
        click_button 'Submit'
        expect(page).to have_content("There are problems with the provided information.")
        expect(page).to have_content("Description can't be blank")
      end

      it "when missing a price" do
        fill_in :Price, with: ""
        click_button 'Submit'
        expect(page).to have_content("There are problems with the provided information.")
        expect(page).to have_content("Price can't be blank")
      end

      it "when price below 0" do
        fill_in :Price, with: "-999.99"
        click_button 'Submit'
        expect(page).to have_content("There are problems with the provided information.")
        expect(page).to have_content("Price must be greater than or equal to 0")
      end

      it "when missing a quantity" do
        fill_in :Quantity, with: ""
        click_button 'Submit'
        expect(page).to have_content("There are problems with the provided information.")
        expect(page).to have_content("Quantity can't be blank")
      end

      it "when quantity below 0" do
        fill_in :Quantity, with: "-990"
        click_button 'Submit'
        expect(page).to have_content("There are problems with the provided information.")
        expect(page).to have_content("Quantity must be greater than or equal to 0")
      end
    end

    it 'I can edit existing items' do
      within "#item-#{@item.id}" do
        click_link 'Edit Item'
      end

      expect(current_path).to eq(edit_admin_merchant_item_path(@merchant, @item))

      fill_in :Name, with: "Updated Item Name"
      click_button :Submit

      expect(current_path).to eq(admin_merchant_items_path(@merchant))
      expect(page).to have_content("You have updated an item.")

      within "#item-#{@item.id}" do
        expect(page).to have_content("Updated Item Name")
        expect(page).to have_content(@item.description)
        expect(page).to have_content(@item.price)
        expect(page).to have_content(@item.quantity)
      end
    end

    describe 'I am unable to edit items when' do
      before :each do
        visit edit_admin_merchant_item_path(@merchant, @item)

        fill_in :Name, with: @new_item.name
        fill_in :Description, with: @new_item.description
        fill_in :Price, with: @new_item.price
        fill_in :Quantity, with: @new_item.quantity
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

    it 'I can delete an unordered item' do
      within "#item-#{@item.id}" do
        click_button :Delete
      end

      expect(page).to have_content("Item ##{@item.id} has been deleted.")

      expect(page).to_not have_css("#item-#{@item.id}")
    end

    it 'I can enable a disabled item.' do
      order_item = create(:order_item)
      order_item.item = @item
      @item.update(disabled: true)
      visit admin_merchant_items_path(@merchant)

      within "#item-#{@item.id}" do
        click_button :Enable
      end

      expect(page).to have_content("Item ##{@item.id} is now available for sale.")

      within "#item-#{@item.id}" do
        expect(page).to have_button(:Disable)
      end
    end

    it 'I can disable an enabled item that has been sold' do
      order_item = create(:order_item)
      order_item.item = @item
      visit admin_merchant_items_path(@merchant)

      within "#item-#{@item.id}" do
        click_button :Disable
      end

      expect(page).to have_content("Item ##{@item.id} is no longer available for sale.")

      within "#item-#{@item.id}" do
        expect(page).to have_button(:Enable)
      end
    end
  end
end
