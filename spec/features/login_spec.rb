require 'rails_helper'

RSpec.describe 'when I visit login path' do
  it 'allows me to log in as a regular user' do
    user = build(:user)

    user.save

    login_as(user)

    expect(current_path).to eq(profile_path)
    expect(page).to have_content("You are now logged in")
  end

  it 'allows me to log in as a merchant' do
    user = build(:merchant)
    user.save

    login_as(user)

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("You are now logged in")
  end

  it 'allows me to log in as an admin' do
    user = build(:admin)
    user.save

    login_as(user)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You are now logged in")
  end

  it 'does not allow me to log in with bad credentials' do
    visit login_path

    fill_in "Email", with: "bad email"
    fill_in "Password", with: "bad password"

    click_button "Login"

    expect(page).to have_content("Invalid email and/or password")
    expect(page).to have_field("Email")
    expect(page).to have_field("Password")
  end

  context 'as a logged in registered user' do

    it 'redirects me to my home page if I am already logged in' do
      user = build(:user)
      user.save

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit login_path

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You are already logged in")
    end
  end

  context 'as a logged in merchant user' do
    it 'redirects me to my merchant dashboard' do
      user = build(:merchant)
      user.save

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit login_path

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("You are already logged in")
    end
  end

  context 'as a logged in admin user' do
    it 'redirects me to the home page' do
      user = build(:admin)
      user.save

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit login_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You are already logged in")

    end
  end
end
