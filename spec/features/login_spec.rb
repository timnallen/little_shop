require 'rails_helper'

RSpec.describe 'when I visit login path' do
  it 'allows me to log in as a regular user' do
    user = build(:user)

    user.save

    visit login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "Log In"

    expect(current_path).to eq(profile_path)
    expect(page).to have_content("You are now logged in")
  end

  it 'allows me to log in as a merchant' do
    user = build(:merchant)
    user.save

    visit login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "Log In"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("You are now logged in")
  end

  it 'allows me to log in as an admin' do
    user = build(:admin)
    user.save

    visit login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "Log In"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You are now logged in")
  end

  it 'does not allow me to log in with bad credentials' do
    visit login_path

    fill_in "Email", with: "bad email"
    fill_in "Password", with: "bad password"

    click_on "Log In"

    expect(page).to have_content("Invalid email and/or password")
    expect(page).to have_field("Email")
    expect(page).to have_field("Password") 
  end
end
