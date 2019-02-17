require 'rails_helper'

RSpec.describe 'admin views user profile' do
  it 'redirects me to a merchant dashboard if the user is a merchant' do
    merchant = create(:merchant)
    user = create(:user)
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)


    visit admin_user_path(merchant)

    expect(current_path).to eq(admin_merchant_path(merchant))
  end

  it 'shows the same info the user sees' do
    user = create(:user)
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_user_path(user)

    expect(page).to have_content("Name: #{user.name}")
    expect(page).to have_content("Email: #{user.email}")
    expect(page).to have_content("Address: #{user.address}")
    expect(page).to have_content("City: #{user.city}")
    expect(page).to have_content("State: #{user.state}")
    expect(page).to have_content("Zip code: #{user.zipcode}")

    expect(page).to_not have_content(user.password)
  end

  it 'shows a link to edit the user/s profile data' do
    user = create(:user)
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_user_path(user)

    expect(page).to have_link("Edit profile")
  end

  describe 'and I click on Edit profile' do
    it 'I can edit their profile data' do
      user = create(:user)
      admin = create(:admin)

      login_as(admin)

      visit admin_user_path(user)
      click_link("Edit profile")

      expect(find_field("Name").value).to eq(user.name)
      expect(find_field("Email").value).to eq(user.email)
      expect(find_field("City").value).to eq(user.city)
      expect(find_field("State").value).to eq(user.state)
      expect(find_field("Zipcode").value).to eq(user.zipcode.to_s)
      expect(find_field("Address").value).to eq(user.address)
      expect(find_field("Password").value).to eq(nil)

      fill_in "Name", with: "editedname"
      fill_in "Email", with: "new_email@email.com"
      click_button "Submit"

      expect(page).to have_content("User profile has been updated")
      expect(page).to have_content("Name: editedname")
      expect(page).to have_content("Email: new_email@email.com")

      expect(current_path).to eq(admin_user_path(user))
    end

    it 'wont allow me to update without all the right info' do
      user = create(:user)
      admin = create(:admin)

      login_as(admin)

      visit admin_user_path(user)
      click_link("Edit profile")

      expect(find_field("Name").value).to eq(user.name)
      expect(find_field("Email").value).to eq(user.email)
      expect(find_field("City").value).to eq(user.city)
      expect(find_field("State").value).to eq(user.state)
      expect(find_field("Zipcode").value).to eq(user.zipcode.to_s)
      expect(find_field("Address").value).to eq(user.address)
      expect(find_field("Password").value).to eq(nil)

      fill_in "Name", with: ""
      click_button "Submit"

      expect(page).to have_content("Name can't be blank")
    end
  end
end
