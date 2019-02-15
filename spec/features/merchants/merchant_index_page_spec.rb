require 'rails_helper'

RSpec.describe 'when I visit the merchant index page' do
  before :each do
    @active_merchants = create_list(:merchant, 4)
  end

  context 'as a visitor' do
    it "I see a list of all merchants in the system" do
      visit merchants_path

      @active_merchants.each do |merchant|
        within "#merchant-#{merchant.id}" do
          expect(page).to have_content(merchant.name)
        end
      end
    end

    it 'I only see merchants who are active' do
      inactive_merchant = build(:inactive_merchant)
      inactive_merchant.save

      visit merchants_path

      expect(page).to_not have_css("#merchant-#{inactive_merchant.id}")
      expect(page).to_not have_content(inactive_merchant.name)
    end

    it "Next to each merchants namer I also see their city and state" do
      visit merchants_path

      @active_merchants.each do |merchant|
        within "#merchant-#{merchant.id}" do
          expect(page).to have_content("From: #{merchant.city}, #{merchant.state}")
        end
      end
    end

    it "I also see the date each merchant registered" do
      visit merchants_path

      @active_merchants.each do |merchant|
        within "#merchant-#{merchant.id}" do
          expect(page).to have_content("Registered: #{merchant.created_at}")
        end
      end
    end
  end

  context 'as an admin' do
    it 'next to each active merchants name I see a button to disable them' do
      admin = build(:admin)
      admin.save
      login_as(admin)
      visit merchants_path

      @active_merchants.each do |merchant|
        within "#merchant-#{merchant.id}" do
          expect(page).to have_button("Disable")
        end
      end
    end

    it 'next to each inactive_merchant I see a button to enable them' do
      inactive_merchant = build(:inactive_merchant)
      inactive_merchant.save
      admin = build(:admin)
      admin.save
      login_as(admin)
      visit merchants_path

      within "#merchant-#{inactive_merchant.id}" do
        expect(page).to have_button("Enable")
      end
    end

    it 'each merchant name is a link to their dashboard' do
      admin = build(:admin)
      admin.save
      login_as(admin)
      visit merchants_path

      @active_merchants.each do |merchant|
        within "#merchant-#{merchant.id}" do
          expect(page).to have_link(merchant.name)
        end
      end
    end
  end
end
