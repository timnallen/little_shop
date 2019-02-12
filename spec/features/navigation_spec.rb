require 'rails_helper'

RSpec.describe 'When I visit any page on the website' do
  context 'as a visitor' do

    it 'I see a navigation bar with links to all pages a visitor can access' do
      visit '/'

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

  context 'as a registered user' do
    xit 'I see a 404 error if I try to go to any /dashboard path' do
    end

    xit 'I see a 404 error if I try to go to any /admin path' do
    end


  end

  context 'as a merchant' do

    it 'I see a 404 error if I try to go to any /profile path ' do
    end

    it 'I see a 404 error if I try to go to any /admin path' do
    end

    it 'I see a 404 error if I try to go to any /cart path' do
    end

  end

  context 'as an admin' do

    it 'I see a 404 error if I try to go to any /dashboard path' do
    end

    it 'I see a 404 error if I try to go to any /cart path' do
    end
  end

end
