require 'rails_helper'

RSpec.describe 'Merchant dashboard page' do
  before :each do
    @merchant = create(:merchant)
  end
  context 'as a merchant' do
    describe 'when I visit my merchant dashboard' do
      it 'I see my profile data, but cannot edit it' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

        visit merchant_user_path(@merchant)

        expect(page).to have_content("Username: #{@merchant.name}")
        expect(page).to have_content("Email: #{@merchant.email}")
        expect(page).to have_content("Address: #{@merchant.address}")
        expect(page).to have_content("City: #{@merchant.city}")
        expect(page).to have_content("State: #{@merchant.state}")
        expect(page).to have_content("Zip code: #{@merchant.zipcode}")
        expect(page).to_not have_link('Edit my profile')
      end
    end
  end
end
