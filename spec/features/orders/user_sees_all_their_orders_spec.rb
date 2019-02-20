require 'rails_helper'

RSpec.describe 'as a registered user viewing all my orders', type: :feature do
  it 'shows me every order Ive made and info about them' do
    user = create(:user)
    item_1 = create(:item)
    item_2 = create(:item)
    order = create(:order, user: user)
    create(:order_item, order: order, item: item_1)
    create(:order_item, order: order, item: item_2)

    login_as(user)

    visit profile_orders_path

    expect(page).to have_content(order.id)
    expect(page).to have_content(order.created_at.strftime("%B, %d %Y at %I:%M %p"))
    expect(page).to have_content(order.updated_at.strftime("%B, %d %Y at %I:%M %p"))
    expect(page).to have_content(order.status)
    expect(page).to have_content(order.quantity_of_items)
    expect(page).to have_content(number_to_currency(order.grand_total))
  end
end
