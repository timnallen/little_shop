require 'rails_helper'

RSpec.describe 'When I visit any page on the website' do
  context 'as a visitor' do

    before :all do
      visit '/'
    end

    it 'I see a navigation bar with links to all pages a visitor can access' do
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
end
