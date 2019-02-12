require 'rails_helper'

RSpec.describe 'User profile page' do
  context 'as a registered user' do
    describe 'when I visit my profile' do
      it 'I see all of my profile data except for my password' do
        user = build(:user)
        user.save
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit profile_path

        expect(page).to have_content("Username: #{user.name}")
        expect(page).to have_content("Email: #{user.email}")
        expect(page).to have_content("Address: #{user.address}")
        expect(page).to have_content("City: #{user.city}")
        expect(page).to have_content("State: #{user.state}")
        expect(page).to have_content("Zip code: #{user.zipcode}")

        expect(page).to_not have_content(user.password)
      end

      it 'I see a link to edit my profile data' do
        user = build(:user)
        user.save
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit profile_path

        expect(page).to have_link("Edit my profile")

      end
    end
  end
end
