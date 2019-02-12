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

    it 'I see a 404 error if I try to go to any /profile path' do
      visit profile_path

      expect(page).to have_content("The page you were looking for doesn't exist")
    end

    it 'I see a 404 error if I try to go to any /dashboard path' do
      visit dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist")
    end

    xit 'I see a 404 error if I try to go to any /admin path' do

    end

  end

  context 'as a user' do

    xit 'I see a 404 error if I try to go to any /dashboard path' do
    end

    xit 'I see a 404 error if I try to go to any /admin path' do
    end

    it 'I see a user navigation bar' do
      user = build(:user)
      user.save

      visit login_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_on "Log In"

      expect(page).to have_content("Logged in as: #{user.name}")

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

  context 'as a merchant' do

    it 'I see a 404 error if I try to go to any /profile path ' do
    end

    it 'I see a 404 error if I try to go to any /admin path' do
    end

    it 'I see a 404 error if I try to go to any /cart path' do
    end

    it 'I see a merchant navigation bar' do
      user = build(:merchant)
      user.save

      visit login_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_on "Log In"

      expect(page).to have_content("Logged in as: #{user.name}")

      expect(page).to_not have_link("Login")

      expect(page).to_not have_link("Register")

      expect(page).to_not have_link("My Cart")

      click_link 'Placeholder Site Name'
      expect(current_path).to eq(welcome_index_path)

      click_link 'Items'
      expect(current_path).to eq(items_path)

      click_link 'Merchants'
      expect(current_path).to eq(users_path)

      click_link 'My Dashboard'
      expect(current_path).to eq(dashboard_path)

      click_link 'Logout'
      expect(current_path).to eq(root_path)
    end
  end

  context 'as a administrator' do

    it 'I see a 404 error if I try to go to any /dashboard path' do
    end

    it 'I see a 404 error if I try to go to any /cart path' do
    end

    it 'I see an admin navigation bar' do
      user = build(:admin)
      user.save

      visit login_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_on "Log In"

      expect(page).to have_content("Logged in as: #{user.name}")

      expect(page).to_not have_link("Login")

      expect(page).to_not have_link("Register")

      expect(page).to_not have_link("My Cart")

      click_link 'Placeholder Site Name'
      expect(current_path).to eq(welcome_index_path)

      click_link 'Items'
      expect(current_path).to eq(items_path)

      click_link 'Merchants'
      expect(current_path).to eq(users_path)

      click_link 'My Dashboard'
      expect(current_path).to eq(admin_dashboard_path)

      click_link 'All Users'
      expect(current_path).to eq(admin_users_path)

      click_link 'Logout'
      expect(current_path).to eq(root_path)
    end
  end
end
