require 'rails_helper'

RSpec.describe 'item show spec' do
  describe 'reviews ext' do
    it 'I see an average review rating for that item' do
      merchant = create(:merchant)
      user_1 = create(:user)
      item_1 = merchant.items.create(name: "Thing 1", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 20.987, quantity: 1)
      order_1 = create(:order, user: user_1)
      order_item_1 = create(:order_item, item: item_1, order: order_1)
      user_1.reviews.create(title: "1", description: "2", rating: 3, order_item: order_item_1)

      user_2 = create(:user)
      order_2 = create(:order, user: user_2)
      order_item_2 = create(:order_item, item: item_1, order: order_2)
      user_2.reviews.create(title: "1", description: "2", rating: 1, order_item: order_item_2)

      visit item_path(item_1)

      expect(page).to have_content(item_1.average_review_rating)
      expect(page).to have_content("Average Review Rating: 2")
    end
  end

  it 'shows the items info' do
    merchant = create(:merchant)
    item_1 = merchant.items.create(name: "Thing 1", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 20.987, quantity: 1)

    visit item_path(item_1)

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_1.description)
    expect(page).to have_css("img[src*='#{item_1.image}']")
    expect(page).to have_content(item_1.user.name)
    expect(page).to have_content("Current Price: #{number_to_currency(item_1.price)}")
    expect(page).to have_content("Stock: #{item_1.quantity}")
    expect(page).to have_content(item_1.average_fulfillment_time)
  end

  it 'shows a link if I am a regular user or visitor to add that item to my cart' do
    merchant = create(:merchant)
    item_1 = merchant.items.create(name: "Thing 1", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 20.987, quantity: 1)

    visit item_path(item_1)

    expect(page).to have_link("Add to Shopping Cart")

    visit root_path

    user = build(:user)
    user.save

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit item_path(item_1)

    expect(page).to have_link("Add to Shopping Cart")
  end

  it 'doesnt show a link if I am a merchant or an admin to add that item to my cart' do
    merchant = build(:merchant)
    merchant.save
    item_1 = merchant.items.create(name: "Thing 1", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 20.987, quantity: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

    visit item_path(item_1)

    expect(page).to_not have_link("Add to Shopping Cart")

    visit root_path

    admin = build(:admin)
    admin.save

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    expect(page).to_not have_link("Add to Shopping Cart")
  end
end
