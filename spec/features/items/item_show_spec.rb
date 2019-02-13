require 'rails_helper'

RSpec.describe 'item show spec' do
  xit 'shows the items info' do
    merchant = build(:merchant)
    merchant.save
    item_1 = merchant.items.create(name: "Thing 1", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 20.987, quantity: 1)

    visit item_path(item_1)

    save_and_open_page

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_1.description)
    expect(page).to have_css("img[src*='#{item_1.image}']")
    expect(page).to have_content(item_1.user.name)
    expect(page).to have_content("Current Price: #{item_1.price}")
    expect(page).to have_content("Stock: #{item_1.quantity}")
    expect(page).to have_content(item_1.average_fulfillment_time)
  end
end
