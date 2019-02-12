require 'rails_helper'

RSpec.describe 'Log out' do
   context 'As a registered user' do
     it 'redirects me to the home page when I log out and I see a message' do
     user = build(:user)
     user.save

     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

     visit logout_path

     expect(current_path).to eq(root_path)
     expect(page).to have_content("You have been logged out")

     visit profile_path
     expect(page).to have_content("The page you were looking for doesn't exist")
    end
   end

   context 'As a merchant' do

     it 'redirects me to the home page when I log out and I see a message' do
     user = build(:merchant)
     user.save

     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

     visit logout_path

     expect(current_path).to eq(root_path)
     expect(page).to have_content("You have been logged out")

     visit dashboard_path
     expect(page).to have_content("The page you were looking for doesn't exist")

    end
   end

   context 'As an admin' do

     it 'redirects me to the home page when I log out and I see a message' do
     user = build(:admin)
     user.save

     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

     visit logout_path

     expect(current_path).to eq(root_path)
     expect(page).to have_content("You have been logged out")

     visit dashboard_path
     expect(page).to have_content("The page you were looking for doesn't exist")
    end
   end
 end
