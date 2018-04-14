require 'rails_helper'

describe 'Visitor' do
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
      user   = create(:user)
      orders = create_list(:order, 10)
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
