require 'rails_helper'

RSpec.describe 'When I visit any page on the website' do

  before :each do
    visit '/'
  end

  context 'as a visitor' do

    it 'I see a visitor navigation bar' do
      click_link 'Store64'
      expect(current_path).to eq(root_path)

      click_link 'Items'
      expect(current_path).to eq(items_path)

      click_link 'Merchants'
      expect(current_path).to eq(merchants_path)

      click_link 'Cart'
      expect(current_path).to eq(cart_path)

      click_link 'Login'
      expect(current_path).to eq(login_path)

      click_link 'Register'
      expect(current_path).to eq(register_path)
    end

    it 'I see a 404 error if I try to go to any /profile path' do
      visit profile_path

      expect(page).to have_content("The page you were looking for doesn't exist")
    end

    it  'I see a 404 error if I try to go to any /dashboard path' do
      visit dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist")
    end

    it 'I see a 404 error if I try to go to any /admin path' do
      visit admin_dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end

  context 'as a user' do
    before :each do
      @user = build(:user)
      @user.save

      login_as(@user)
    end

    it 'I see a 404 error if I try to go to any /dashboard path' do
      visit dashboard_path
      expect(page).to have_content("The page you were looking for doesn't exist")
    end

    it 'I see a 404 error if I try to go to any /admin path' do
      visit admin_users_path
      expect(page).to have_content("The page you were looking for doesn't exist")

    end

    it 'I see a user navigation bar' do
      expect(page).to have_content("Logged in as: #{@user.name}")

      expect(page).to_not have_link("Login")

      expect(page).to_not have_link("Register")

      click_link 'Store64'
      expect(current_path).to eq(root_path)

      click_link 'Items'
      expect(current_path).to eq(items_path)

      click_link 'Merchants'
      expect(current_path).to eq(merchants_path)

      click_link 'Cart'
      expect(current_path).to eq(cart_path)

      click_link 'My Profile'
      expect(current_path).to eq(profile_path)

      click_link 'My Orders'
      expect(current_path).to eq(profile_orders_path)

      click_link 'Logout'
      expect(current_path).to eq(root_path)
    end
  end

  context 'as a merchant' do
    before :each do
      @user = build(:merchant)
      @user.save

      login_as(@user)
    end

    it 'I see a 404 error if I try to go to any /profile path ' do
      visit profile_path

      expect(page).to have_content("The page you were looking for doesn't exist")

    end

    it 'I see a 404 error if I try to go to any /admin path' do
      visit admin_users_path
      expect(page).to have_content("The page you were looking for doesn't exist")

      visit admin_dashboard_path
      expect(page).to have_content("The page you were looking for doesn't exist")

    end

    it 'I see a 404 error if I try to go to any /cart path' do
      visit cart_path
      expect(page).to have_content("The page you were looking for doesn't exist")
    end

    it 'I see a merchant navigation bar' do
      expect(page).to have_content("Logged in as: #{@user.name}")

      expect(page).to_not have_link("Login")

      expect(page).to_not have_link("Register")

      expect(page).to_not have_link("Cart")

      click_link 'Store64'
      expect(current_path).to eq(root_path)

      click_link 'Items'
      expect(current_path).to eq(items_path)

      click_link 'Merchants'
      expect(current_path).to eq(merchants_path)

      click_link 'My Dashboard'
      expect(current_path).to eq(dashboard_path)

      click_link 'Logout'
      expect(current_path).to eq(root_path)
    end
  end

  context 'as a administrator' do
    before :each do
      @user = build(:admin)
      @user.save

      login_as(@user)

    end

    it 'I see a 404 error if I try to go to any /dashboard path' do
      visit dashboard_path
      expect(page).to have_content("The page you were looking for doesn't exist")

    end

    it 'I see a 404 error if I try to go to any /cart path' do
      visit cart_path
      expect(page).to have_content("The page you were looking for doesn't exist")
    end

    it 'I see an admin navigation bar' do
      expect(page).to have_content("Logged in as: #{@user.name}")

      expect(page).to_not have_link("Login")

      expect(page).to_not have_link("Register")

      expect(page).to_not have_link("Cart")

      click_link 'Store64'
      expect(current_path).to eq(root_path)

      click_link 'Items'
      expect(current_path).to eq(items_path)

      click_link 'Merchants'
      expect(current_path).to eq(merchants_path)

      click_link 'My Dashboard'
      expect(current_path).to eq(admin_dashboard_path)

      click_link 'All Users'
      expect(current_path).to eq(admin_users_path)

      click_link 'Logout'
      expect(current_path).to eq(root_path)
    end
  end
end
