require 'rails_helper'

RSpec.describe 'When I click on register in the nav bar' do
  context 'as a visitor' do
    describe 'I am taken to a form to create a new user' do
      it 'where I can create a new user' do
        visit root_path
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
        click_button 'Submit'

        expect(current_path).to eq(profile_path)

        expect(page).to have_content('You are now registered and logged in!')
        expect(page).to have_link("Logout")
        expect(page).to have_content("John Smith")
      end

      it 'which will send an error message if I enter invalid information' do
        visit register_path

        fill_in 'user[zipcode]', with: 'abc'
        click_button 'Submit'

        expect(current_path).to eq(users_path)

        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("City can't be blank")
        expect(page).to have_content("State can't be blank")
        expect(page).to have_content("Password can't be blank")
      end

      it 'which will display a message if I enter a existing email' do
        tim = build(:user)
        tim.save

        visit register_path

        fill_in 'user[name]', with: 'John Smith'
        fill_in 'user[address]', with: '123 Main Street'
        fill_in 'user[city]', with: 'Denver'
        fill_in 'user[state]', with: 'CO'
        fill_in 'user[zipcode]', with: '12345'
        fill_in 'user[email]', with: tim.email
        fill_in 'user[password]', with: 'abc123'
        fill_in 'user[password_confirmation]', with: 'abc123'
        click_button 'Submit'

        expect(current_path).to eq(users_path)
        expect(page).to have_content('Email has already been taken')
        expect(page).to_not have_content(tim.email)
      end

      it 'which will display a message if I enter an email that is a different case but same letters' do
        tim = build(:user, email: "tim@email.com")
        tim.save

        visit register_path

        fill_in 'user[name]', with: 'John Smith'
        fill_in 'user[address]', with: '123 Main Street'
        fill_in 'user[city]', with: 'Denver'
        fill_in 'user[state]', with: 'CO'
        fill_in 'user[zipcode]', with: '12345'
        fill_in 'user[email]', with: "TIM@email.com"
        fill_in 'user[password]', with: 'abc123'
        fill_in 'user[password_confirmation]', with: 'abc123'
        click_button 'Submit'

        expect(current_path).to eq(users_path)
        expect(page).to have_content('Email has already been taken')
        expect(page).to_not have_content(tim.email)
      end
    end
  end
end
