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
      login_as(@merchant)

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
        expect(page).to have_css("img[src='https://via.placeholder.com/200x300?text=LittleShop']")
      end
    end

    describe 'I am unable to add an item' do
      before :each do
        login_as(@merchant)

        visit new_dashboard_item_path

        fill_in :Name, with: @valid_item.name
        fill_in :Description, with: @valid_item.description
        fill_in :Image, with: @valid_item.image
        fill_in :Price, with: @valid_item.price
        fill_in :Quantity, with: @valid_item.quantity
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
  end
end
