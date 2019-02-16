require 'rails_helper'

RSpec.describe 'admin views merchant dashboard' do
  describe 'as an admin when Im on the merchant index page and I click on a merchant name' do
    before :each do
      @merchant = create(:merchant)
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end

    it 'takes me to the route admin/merchants/:id' do
      visit merchants_path

      click_on "#{@merchant.name}"

      expect(current_path).to eq(admin_merchant_path(@merchant))
    end

    # it 'shows the same info the merchant sees' do
    #
    #   visit admin_user_path(user)
    #
    #   expect(page).to have_content("Name: #{user.name}")
    #   expect(page).to have_content("Email: #{user.email}")
    #   expect(page).to have_content("Address: #{user.address}")
    #   expect(page).to have_content("City: #{user.city}")
    #   expect(page).to have_content("State: #{user.state}")
    #   expect(page).to have_content("Zip code: #{user.zipcode}")
    #
    #   expect(page).to_not have_content(user.password)
    # end
  end
end
