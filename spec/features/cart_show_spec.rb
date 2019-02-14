require 'rails_helper'

RSpec.describe 'cart show page', type: :feature do
  it 'as a user or visitor with no items in my cart, I see a message that my cart is empty' do
    visit cart_path

    expect(page).to have_content("Your cart is empty.")
  end

  it 'it allows me to add items to the cart, shows me a flash message and changes the cart counter in my nav bar' do
    merchant = build(:merchant)
    merchant.save
    item_1 = merchant.items.create(name: "Thing 1", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 20.987, quantity: 1)

    visit item_path(item_1)

    click_on "Add to Shopping Cart"

    expect(current_path).to eq(items_path)
    expect(page).to have_content("You now have 1 copy of #{item_1.name} in your cart!")
    expect(page).to have_content("Cart: 1")
  end
end
