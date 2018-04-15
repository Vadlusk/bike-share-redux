require 'rails_helper'

describe 'User' do
  describe 'as a registered default user' do
    it 'sees profile information on dashboard page' do
      user = create(:user)
      visit root_path
      click_on "Login"

      fill_in 'username', with: user.username
      fill_in 'password', with: user.password
      click_on "Login"

      expect(page).to have_content(user.username)
      expect(page).to have_content(user.email)
    end
    it 'sees orders' do
      user    = create(:user)
      order_1 = user.orders.create!(status: 'paid')
      order_2 = user.orders.create!(status: 'cancelled')
      order_3 = user.orders.create!(status: 'completed')
      order_4 = user.orders.create!(status: 'ordered')
      order_5 = user.orders.create!(status: 'paid')
      orders  = [order_1, order_2, order_3, order_4, order_5]

      visit root_path
      click_on "Login"

      fill_in 'username', with: user.username
      fill_in 'password', with: user.password
      click_on "Login"

      orders.each do |order|
        expect(page).to have_content(order.id)
      end
    end
  end
end
