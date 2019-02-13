require 'rails_helper'

RSpec.describe 'User profile page' do
  context 'as a registered user' do
    before :all do
      User.destroy_all
      @user = build(:user)
      @user.save
    end
    describe 'when I visit my profile' do
      it 'I see all of my profile data except for my password' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit profile_path

        expect(page).to have_content("Username: #{@user.name}")
        expect(page).to have_content("Email: #{@user.email}")
        expect(page).to have_content("Address: #{@user.address}")
        expect(page).to have_content("City: #{@user.city}")
        expect(page).to have_content("State: #{@user.state}")
        expect(page).to have_content("Zip code: #{@user.zipcode}")

        expect(page).to_not have_content(@user.password)
      end

      it 'I see a link to edit my profile data' do
        user = build(:user)
        user.save
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit profile_path

        expect(page).to have_link("Edit my profile")

      end

      describe 'and I click on Edit my profile' do
        it 'redirects me to an edit form' do

          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

          visit profile_path
          click_link "Edit my profile"


          expect(current_path).to eq(profile_edit_path)

          expect(find_field("Name").value).to eq(@user.name)
          expect(find_field("Email").value).to eq(@user.email)
          expect(find_field("City").value).to eq(@user.city)
          expect(find_field("State").value).to eq(@user.state)
          expect(find_field("Zipcode").value).to eq(@user.zipcode.to_s)
          expect(find_field("Address").value).to eq(@user.address)
          expect(find_field("Password").value).to eq(nil)

          fill_in "Name", with: "chris123"
          click_button "Update User"

          expect(current_path).to eq(profile_path)
          expect(page).to have_content("Your profile has been updated")
          expect(page).to have_content("Username: chris123")

        end
      end
    end

  end
end
