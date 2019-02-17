require 'rails_helper'

RSpec.describe 'Admin user show page' do
  context 'as an admin' do
    describe 'when I visit a user\'s profile page' do
      it 'I can upgrade that user to become a merchant' do
        user = create(:user)
        admin = create(:admin)

        login_as(user)

        expect(current_path).to eq(profile_path)

        click_link('Logout')
        login_as(admin)
        visit admin_user_path(user)
        click_link 'Upgrade'

        expect(current_path).to eq(admin_merchant_path(user))
        expect(page).to have_content("You have upgraded a user")

        click_link('Logout')
        login_as(user)

        expect(current_path).to eq(dashboard_path)
      end
    end
  end
end
