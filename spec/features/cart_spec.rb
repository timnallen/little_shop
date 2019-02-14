require 'rails_helper'

RSpec.describe 'cart show page', type: :feature do
  it 'as a user or visitor with no items in my cart, I see a message that my cart is empty' do
    visit cart_path

    expect(page).to have_content("Your cart is empty.")
  end
end
