require 'rails_helper'

describe 'User' do
  context 'visits order show page' do
    it 'shows info for that order' do
      user        = create(:user)
      order       = create(:order)
      accessories = create_list(:order_accessory, 10)

      visit root_path
      click_on "Login"

      fill_in 'username', with: user.username
      fill_in 'password', with: user.password
      click_on "Login"
      click_on order.id

      expect(current_path).to eq("orders/#{order.id}")
      accessories.each do |accessory|
        expect(page).to have_content(accessory.title)
        expect(page).to have_content(order.accessory.quantity)
        expect(page).to have_content(order.accessory.subtotal)
      end
      expect(page).to have_content(order.total_price)
      expect(page).to have_content(order.status)
      expect(page).to have_content(order.created_at)
    end
  end
end
