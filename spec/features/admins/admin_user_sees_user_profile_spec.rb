require 'rails_helper'

RSpec.describe 'admin views user profile' do
  it 'shows the same info the user sees' do
    user = create(:user)
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_user_path(user)

    expect(page).to have_content("Username: #{user.name}")
    expect(page).to have_content("Email: #{user.email}")
    expect(page).to have_content("Address: #{user.address}")
    expect(page).to have_content("City: #{user.city}")
    expect(page).to have_content("State: #{user.state}")
    expect(page).to have_content("Zip code: #{user.zipcode}")

    expect(page).to_not have_content(user.password)
  end
end
