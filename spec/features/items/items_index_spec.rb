require 'rails_helper'

RSpec.describe 'items index spec' do
  it 'shows all items' do
    merchant = build(:merchant)
    merchant.save
    item_1 = merchant.items.create(name: "Thing 1", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 20.987, quantity: 1)
    item_2 = merchant.items.create(name: "Thing 2", description: "It's another thing", image: "http://www.stickpng.com/assets/thumbs/580b585b2edbce24c47b2a2c.png", price: 1.0, quantity: 444)

    visit items_path

    within "#item-#{item_1.id}" do
      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_1.user.name)
      expect(page).to have_content(item_1.description)
      expect(page).to have_css("img[src*='https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png']")
      expect(page).to have_content("Current price: #{item_1.price}")
      expect(page).to have_content("Stock: #{item_1.quantity}")
    end

    within "#item-#{item_2.id}" do
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_2.user.name)
      expect(page).to have_content(item_2.description)
      expect(page).to have_css("img[src*='http://www.stickpng.com/assets/thumbs/580b585b2edbce24c47b2a2c.png']")
      expect(page).to have_content("Current price: #{item_2.price}")
      expect(page).to have_content("Stock: #{item_2.quantity}")
    end
  end

  it 'doesnt show disabled items' do
    merchant = build(:merchant)
    merchant.save
    item_2 = merchant.items.create(name: "Thing 2", description: "It's another thing", image: "http://www.stickpng.com/assets/thumbs/580b585b2edbce24c47b2a2c.png", price: 1.0, quantity: 444, disabled: true)

    visit items_path

    expect(page).to_not have_content(item_2.name)
    expect(page).to_not have_content(item_2.description)
    expect(page).to_not have_css("img[src*='http://www.stickpng.com/assets/thumbs/580b585b2edbce24c47b2a2c.png']")
    expect(page).to_not have_content("Current price: #{item_2.price}")
    expect(page).to_not have_content("Stock: #{item_2.quantity}")
  end

  it 'shows a link to an items show page' do
    merchant = build(:merchant)
    merchant.save
    item_1 = merchant.items.create(name: "Thing 1", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 20.987, quantity: 1)

    visit items_path

    within "#item-#{item_1.id}" do
      expect(page).to have_link(item_1.name)
    end
    click_on "#{item_1.name}"

    expect(current_path).to eq(item_path(item_1))
  end

  it 'shows an image which is a link to an items show page' do
    merchant = build(:merchant)
    merchant.save
    item_1 = merchant.items.create(name: "Thing 1", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 20.987, quantity: 1)

    visit items_path

    click_link("picture-#{item_1.id}")

    expect(current_path).to eq(item_path(item_1))
  end
end
