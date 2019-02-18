require 'rails_helper'

RSpec.describe 'Admin user show page' do
  context 'as an admin' do
    before :each do
      @item = create(:item)
      @merchant = create(:merchant, items: [@item])
      @user = create(:user)
      @admin = create(:admin)
    end
    describe 'when I visit a user\'s profile page' do
      it 'I can upgrade that user to become a merchant' do
        login_as(@user)

        expect(current_path).to eq(profile_path)

        click_link('Logout')
        login_as(@admin)
        visit admin_user_path(@user)
        click_link 'Upgrade'

        expect(current_path).to eq(admin_merchant_path(@user))
        expect(page).to have_content("You have upgraded a user")

        click_link('Logout')
        login_as(@user)

        expect(current_path).to eq(dashboard_path)
      end
    end

    describe 'when I visit a merchant\'s dashboard page' do
      it 'I can downgrade a merchant to a regular user' do
        login_as(@merchant)

        expect(current_path).to eq(dashboard_path)

        click_link('Items')

        expect(page).to have_content(@item.name)

        click_link('Logout')
        login_as(@admin)
        visit admin_user_path(@merchant)
        click_link 'Downgrade'

        expect(current_path).to eq(admin_user_path(@merchant))
        expect(page).to have_content("You have downgraded a merchant")

        click_link('Logout')
        login_as(@merchant)

        expect(current_path).to eq(profile_path)

        click_link('Items')

        expect(page).to_not have_content(@item.name)
      end
    end
  end
end
