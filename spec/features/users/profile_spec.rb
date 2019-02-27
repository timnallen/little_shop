require 'rails_helper'

RSpec.describe 'User profile page' do
  context 'as a registered user' do
    before :each do
      @user = build(:user)
      @user.save
    end

    describe 'reviews ext' do
      before :each do
        login_as(@user)
      end

      it 'shows me a link to an index page of my reviews' do
        @item = create(:item)
        @order = create(:order, user: @user)
        @order_item = create(:order_item, order: @order, item: @item)
        @review = Review.create(order_item: @order_item, user: @user, title: "Loved this item", description: "Best item I ever purchased", rating: 5)

        visit profile_path

        expect(page).to have_link("My Reviews")
        click_link("My Reviews")

        expect(current_path).to eq(profile_reviews_path)
        expect(page).to have_content("#{@user.name}'s Reviews")

        within "#reviews-#{@review.id}" do
          expect(page).to have_content(@item.name)
          expect(page).to have_content("Loved this item")
          expect(page).to have_content("Best item I ever purchased")
          expect(page).to have_content("Rating: 5")
          expect(page).to have_content("#{@review.created_at.localtime.strftime("%B, %d %Y at %I:%M %p")}")
        end
      end

      it 'allows me to edit my reviews' do
        @item = create(:item)
        @order = create(:order, user: @user)
        @order_item = create(:order_item, order: @order, item: @item)
        @review = Review.create(order_item: @order_item, user: @user, title: "1234", description: "5678", rating: 1)
        visit profile_reviews_path

        within "#reviews-#{@review.id}" do
          expect(page).to have_link("Edit Review")
          click_link("Edit Review")
        end

        expect(current_path).to eq(edit_profile_review_path(@review))

        expect(page).to have_field("Title")
        expect(page).to have_field("Description")
        expect(page).to have_field("Rating")

        fill_in 'review[title]', with: 'Loved this item'
        fill_in 'review[description]', with: 'Best item I ever purchased'
        fill_in 'review[rating]', with: '5'
        click_button 'Submit'

        expect(current_path).to eq(item_path(@item))

        expect(page).to have_content("You have edited your review for #{@item.name}!")

        within "#reviews-#{@review.id}" do
          expect(page).to have_content("Loved this item")
          expect(page).to have_content("Best item I ever purchased")
          expect(page).to have_content("Rating: 5")
          expect(page).to have_content("Created At: #{@review.created_at}")
          expect(page).to have_content("Updated At: #{@review.updated_at}")
        end
      end

      it 'wont let me edit my reviews with empty fields' do
        @item = create(:item)
        @order = create(:order, user: @user)
        @order_item = create(:order_item, order: @order, item: @item)
        @review = Review.create(order_item: @order_item, user: @user, title: "Loved this item", description: "Best item I ever purchased", rating: 5)
        visit profile_reviews_path

        within "#reviews-#{@review.id}" do
          expect(page).to have_link("Edit Review")
          click_link("Edit Review")
        end

        expect(current_path).to eq(edit_profile_review_path(@review))

        expect(page).to have_field("Title")
        expect(page).to have_field("Description")
        expect(page).to have_field("Rating")

        fill_in 'review[title]', with: ''
        fill_in 'review[description]', with: ''
        fill_in 'review[rating]', with: ''
        click_button 'Submit'

        expect(page).to have_content("You are missing required fields.")

        expect(page).to have_content("Title can't be blank")
        expect(page).to have_content("Description can't be blank")
        expect(page).to have_content("Rating can't be blank")
        expect(page).to have_content("Rating is not a number")
      end

      it 'allows me to delete my reviews' do
        @item = create(:item)
        @order = create(:order, user: @user)
        @order_item = create(:order_item, order: @order, item: @item)
        @review = Review.create(order_item: @order_item, user: @user, title: "1234", description: "5678", rating: 1)
        visit profile_reviews_path

        within "#reviews-#{@review.id}" do
          expect(page).to have_link("Delete Review")
          click_link("Delete Review")
        end

        expect(current_path).to eq(profile_reviews_path)

        expect(page).to_not have_content("1234")
        expect(page).to_not have_content("5678")
        expect(page).to_not have_content("Rating: 1")
      end
    end

    describe 'when I visit my profile' do
      it 'I see all of my profile data except for my password' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit profile_path

        expect(page).to have_content("Name: #{@user.name}")
        expect(page).to have_content("Email: #{@user.email}")
        expect(page).to have_content("Address: #{@user.address}")
        expect(page).to have_content("City: #{@user.city}")
        expect(page).to have_content("State: #{@user.state}")
        expect(page).to have_content("Zipcode: #{@user.zipcode}")

        expect(page).to_not have_content(@user.password)
      end

      it 'I see a link to edit my profile data' do

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit profile_path

        expect(page).to have_link("Edit my profile")

      end

      describe 'and I click on Edit my profile' do
        it 'redirects me to an edit form' do
          login_as(@user)

          visit profile_path
          click_link "Edit my profile"

          expect(current_path).to eq(profile_edit_path)
          expect(find_field("Name").value).to eq(@user.name)
          expect(find_field("Email").value).to eq(@user.email)
          expect(find_field("City").value).to eq(@user.city)
          expect(find_field("State").value).to eq(@user.state)
          expect(find_field("Zipcode").value).to eq(@user.zipcode.to_s)
          expect(find_field("Address").value).to eq(@user.address)
          expect(find_field("Password").value).to eq(nil)

          fill_in "Name", with: "chris123"

          click_button "Submit"

          expect(current_path).to eq(profile_path)
          expect(page).to have_content("Your profile has been updated")
          expect(page).to have_content("Name: chris123")
        end

        it 'does not allow me to enter another user\'s email ' do
          user_2 = build(:merchant)
          user_2.save

          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

          visit profile_path
          click_link "Edit my profile"
          fill_in "Email", with: user_2.email
          click_button "Submit"

          expect(page).to have_content('That email is already registered.')
        end
      end

      it 'also shows me a link to my orders on my profile page' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        order = create(:order, user:@user)
        create(:order_item, order: order)

        visit profile_path


        click_link "See My Orders"

        expect(current_path).to eq(profile_orders_path)
      end

      it 'does not show me a link to my orders if I have no orders' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit profile_path

        expect(page).to_not have_link("See My Orders")
      end
    end
  end
end
