require 'rails_helper'

RSpec.describe 'When I visit any page on the website' do
  context 'as a visitor' do

    before :all do
      visit '/'
    end

    describe 'I see a navigation bar with links to' do
      it "home page" do
        click_on 'Placeholder Site Name'
        expect(current_path).to eq(welcome_path)
      end

      it "items index page" do
        click_on 'Items'
        expect(current_path).to eq(items_path)
      end

      it 'merchants index page' do
        click_on 'Merchants'
        expect(current_path).to eq(users_path)
      end

      it 'my shopping cart' do
        click_on 'My Cart'
        expect(current_path).to eq(cart_path)
      end

      it 'a login page' do
        click_on 'Login'
        expect(current_path).to eq(new_session_path)
      end

      it 'a registration page' do
        click_on 'Register'
        expect(current_path).to eq(new_user_path)
      end
    end
  end
end
