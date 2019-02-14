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
    item_1 = merchant.items.create(name: "Thing 1", description: "It's a thing", image: "https://upload.wikimedia.org/wikipedia/en/5/53/Snoopy_Peanuts.png", price: 20.987, quantity: 1)
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

  it 'shows statistics about the most and least popular items' do
    User.destroy_all
    merchant = build(:merchant)
    merchant.save
    user = build(:user)
    user.save!
    order = user.orders.create
    item_1 = merchant.items.create(name: "Item 1", description: "Description 1", price: 1.11, quantity: 1, image: 'https://picsum.photos/200')
    item_2 = merchant.items.create(name: "Item 2", description: "Description 2", price: 2.22, quantity: 2, image: 'https://picsum.photos/200')
    item_3 = merchant.items.create(name: "Item 3", description: "Description 3", price: 3.33, quantity: 3, image: 'https://picsum.photos/200')
    item_4 = merchant.items.create(name: "Item 4", description: "Description 4", price: 4.44, quantity: 4, image: 'https://picsum.photos/200')
    item_5 = merchant.items.create(name: "Item 5", description: "Description 5", price: 5.55, quantity: 5, image: 'https://picsum.photos/200')
    item_6 = merchant.items.create(name: "Item 6", description: "Description 6", price: 6.66, quantity: 6, image: 'https://picsum.photos/200')
    order_items = []
    order_items << OrderItem.create(order: order, item: item_1, unit_price: item_1.price, quantity: 1)
    order_items << OrderItem.create(order: order, item: item_2, unit_price: item_2.price, quantity: 2)
    order_items << OrderItem.create(order: order, item: item_3, unit_price: item_3.price, quantity: 3)
    order_items << OrderItem.create(order: order, item: item_4, unit_price: item_4.price, quantity: 4)
    order_items << OrderItem.create(order: order, item: item_5, unit_price: item_5.price, quantity: 5)
    order_items << OrderItem.create(order: order, item: item_6, unit_price: item_6.price, quantity: 6)
    order_items.each {|order_item| order_item.update(fulfilled: true)}

    visit items_path

    within '#top-selling-items' do
      expect(page).to have_content("Top Selling Items:")
      expect(page).to have_content("#{item_6.name} Quantity: #{order_items[5].quantity}")
      expect(page).to have_content("#{item_5.name} Quantity: #{order_items[4].quantity}")
      expect(page).to have_content("#{item_4.name} Quantity: #{order_items[3].quantity}")
      expect(page).to have_content("#{item_3.name} Quantity: #{order_items[2].quantity}")
      expect(page).to have_content("#{item_2.name} Quantity: #{order_items[1].quantity}")
    end

    within '#worst-selling-items' do
      expect(page).to have_content("Least Sold Items:")
      expect(page).to have_content("#{item_1.name} Quantity: #{order_items[0].quantity}")
      expect(page).to have_content("#{item_2.name} Quantity: #{order_items[1].quantity}")
      expect(page).to have_content("#{item_3.name} Quantity: #{order_items[2].quantity}")
      expect(page).to have_content("#{item_4.name} Quantity: #{order_items[3].quantity}")
      expect(page).to have_content("#{item_5.name} Quantity: #{order_items[4].quantity}")
    end
  end

  it 'only shows statistics for fulfilled items' do
    User.destroy_all
    merchant = build(:merchant)
    merchant.save
    user = build(:user)
    user.save!
    order = user.orders.create
    item_1 = merchant.items.create(name: "Item 1", description: "Description 1", price: 1.11, quantity: 1, image: 'https://picsum.photos/200')
    item_2 = merchant.items.create(name: "Item 2", description: "Description 2", price: 2.22, quantity: 2, image: 'https://picsum.photos/200')
    item_3 = merchant.items.create(name: "Item 3", description: "Description 3", price: 3.33, quantity: 3, image: 'https://picsum.photos/200')
    item_4 = merchant.items.create(name: "Item 4", description: "Description 4", price: 4.44, quantity: 4, image: 'https://picsum.photos/200')
    item_5 = merchant.items.create(name: "Item 5", description: "Description 5", price: 5.55, quantity: 5, image: 'https://picsum.photos/200')
    item_6 = merchant.items.create(name: "Item 6", description: "Description 6", price: 6.66, quantity: 6, image: 'https://picsum.photos/200')
    item_7 = merchant.items.create(name: "Item 7", description: "Description 7", price: 7.77, quantity: 7, image: 'https://picsum.photos/200')
    order_items = []
    order_items << OrderItem.create(order: order, item: item_1, unit_price: item_1.price, quantity: 1)
    order_items << OrderItem.create(order: order, item: item_2, unit_price: item_2.price, quantity: 2)
    order_items << OrderItem.create(order: order, item: item_3, unit_price: item_3.price, quantity: 3)
    order_items << OrderItem.create(order: order, item: item_4, unit_price: item_4.price, quantity: 4)
    order_items << OrderItem.create(order: order, item: item_5, unit_price: item_5.price, quantity: 5)
    order_items << OrderItem.create(order: order, item: item_6, unit_price: item_6.price, quantity: 6)
    order_items.each {|order_item| order_item.update(fulfilled: true)}
    non_fulfilled = OrderItem.create(order: order, item: item_7, unit_price: item_7.price, quantity: 7)

    visit items_path

    within '#top-selling-items' do
      expect(page).to have_content("Top Selling Items:")
      expect(page).to have_content("#{item_6.name} Quantity: #{order_items[5].quantity}")
      expect(page).to have_content("#{item_5.name} Quantity: #{order_items[4].quantity}")
      expect(page).to have_content("#{item_4.name} Quantity: #{order_items[3].quantity}")
      expect(page).to have_content("#{item_3.name} Quantity: #{order_items[2].quantity}")
      expect(page).to have_content("#{item_2.name} Quantity: #{order_items[1].quantity}")
      expect(page).to_not have_content("#{item_7.name} Quantity: #{non_fulfilled.quantity}")
    end

    within '#worst-selling-items' do
      expect(page).to have_content("Least Sold Items:")
      expect(page).to have_content("#{item_1.name} Quantity: #{order_items[0].quantity}")
      expect(page).to have_content("#{item_2.name} Quantity: #{order_items[1].quantity}")
      expect(page).to have_content("#{item_3.name} Quantity: #{order_items[2].quantity}")
      expect(page).to have_content("#{item_4.name} Quantity: #{order_items[3].quantity}")
      expect(page).to have_content("#{item_5.name} Quantity: #{order_items[4].quantity}")
      expect(page).to_not have_content("#{item_7.name} Quantity: #{non_fulfilled.quantity}")
    end
  end
end
