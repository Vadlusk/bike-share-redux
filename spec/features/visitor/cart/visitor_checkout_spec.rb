require 'rails_helper'

describe 'Visitor' do
  describe 'clicks checkout button in cart with contents' do
    it 'and is redirected to login' do
      accessory1 = Accessory.create!(title: "help", description: "Bad", price: 100, image_url: "", status: 0)

      visit bike_shop_path

      within(".accessory-#{accessory1.id}") do
        click_button("Add to Cart")
      end

      visit '/cart'
      click_on 'Checkout'
      expect(current_path).to eq(login_path)
    end
  end

  context 'logged in as a registered default user' do
    describe 'clicks checkout button in cart with contents' do
      it 'and creates order and associated OrderAccessories' do
        user = create(:user)
        accessory1 = Accessory.create!(title: "help", description: "Bad", price: 100, image_url: "", status: 0)
        accessory2 = Accessory.create!(title: "halp", description: "Bed", price: 100, image_url: "", status: 0)

        visit login_path

        fill_in 'username', with: user.username
        fill_in 'password', with: user.password
        click_on 'Login'

        visit bike_shop_path

        within(".accessory-#{accessory1.id}") do
          click_button("Add to Cart")
        end

        within(".accessory-#{accessory2.id}") do
          click_button("Add to Cart")
        end

        visit '/cart'
        click_on 'Checkout'
        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("Successfully submitted your order totaling #{(accessory1.price + accessory2.price).to_f}")
        expect(Order.last.user_id).to eq(user.id)
        expect(OrderAccessory.last.order_id).to eq(Order.last.id)
      end
    end

    describe 'checks out' do
      it 'and cart contents are cleared' do
        user = create(:user)
        accessory1 = Accessory.create!(title: "Tire", description: "rolls", price: 100, image_url: "", status: 0)
        accessory2 = Accessory.create!(title: "Tyre", description: "roles", price: 100, image_url: "", status: 0)

        visit login_path

        fill_in 'username', with: user.username
        fill_in 'password', with: user.password
        click_on 'Login'

        visit bike_shop_path

        within(".accessory-#{accessory1.id}") do
          click_button("Add to Cart")
        end

        within(".accessory-#{accessory2.id}") do
          click_button("Add to Cart")
        end

        visit '/cart'
        click_on 'Checkout'
        visit '/cart'

        expect(page).to_not have_content(accessory1.title)
        expect(page).to_not have_content(accessory2.title)

        within(".cart") do
          expect(page).to have_content("(0)")
        end
      end
    end

    describe 'checks out' do
      it 'and can add items to the cart again' do
        user = create(:user)
        accessory1 = Accessory.create!(title: "Tire", description: "rolls", price: 100, image_url: "", status: 0)
        accessory2 = Accessory.create!(title: "Tyre", description: "roles", price: 100, image_url: "", status: 0)

        visit login_path

        fill_in 'username', with: user.username
        fill_in 'password', with: user.password
        click_on 'Login'

        visit bike_shop_path

        within(".accessory-#{accessory1.id}") do
          click_button("Add to Cart")
        end

        visit '/cart'
        click_on 'Checkout'

        visit bike_shop_path

        within(".accessory-#{accessory2.id}") do
          click_button("Add to Cart")
        end

        visit '/cart'
        expect(page).to_not have_content(accessory1.title)
        expect(page).to have_content(accessory2.title)
      end
    end
  end
end
