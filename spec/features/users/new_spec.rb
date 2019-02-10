require 'rails_helper'

RSpec.describe 'When I click on register in the nav bar' do
  context 'as a visitor' do
    it 'I am taken to a form to create a new user' do
      visit welcome_index_path
      click_link 'Register'

      expect(current_path).to eq(register_path)

      fill_in 'user[name]', with: 'John Smith'
      fill_in 'user[address]', with: '123 Main Street'
      fill_in 'user[city]', with: 'Denver'
      fill_in 'user[state]', with: 'CO'
      fill_in 'user[zipcode]', with: '12345'
      fill_in 'user[email]', with: 'johns@gmail.com'
      fill_in 'user[password]', with: 'abc123'
      fill_in 'user[password_confirmation]', with: 'abc123'
      click_button 'Register'

      expect(current_path).to eq(profile_path)

      expect(page).to have_content('You are now registered and logged in!')
    end
  end
end
