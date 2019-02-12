require 'rails_helper'

RSpec.describe 'When I visit any page on the website' do

  before :each do
    visit '/'
  end
  context 'as a visitor' do


    it 'I see a visitor navigation bar' do
      click_link 'Placeholder Site Name'
      expect(current_path).to eq(welcome_index_path)

      click_link 'Items'
      expect(current_path).to eq(items_path)

      click_link 'Merchants'
      expect(current_path).to eq(users_path)

      click_link 'My Cart'
      expect(current_path).to eq(cart_path)

      click_link 'Login'
      expect(current_path).to eq(login_path)

      click_link 'Register'
      expect(current_path).to eq(register_path)
    end
  end

  context 'as a user' do
    it 'I see a user navigation bar' do
      user = build(:user)
      allow_any_instance_of(ApplicationController).to recieve(:current_user).and_return(user)
      expect(page).to_not have_link("Login")

      expect(page).to_not have_link("Register")

      click_link 'Placeholder Site Name'
      expect(current_path).to eq(welcome_index_path)

      click_link 'Items'
      expect(current_path).to eq(items_path)

      click_link 'Merchants'
      expect(current_path).to eq(users_path)

      click_link 'My Cart'
      expect(current_path).to eq(cart_path)

      click_link 'My Profile'
      expect(current_path).to eq(profile_path)

      click_link 'My Orders'
      expect(current_path).to eq(profile_orders_path)

      click_link 'Logout'
      expect(current_path).to eq(root_path)
    end
  end
end
