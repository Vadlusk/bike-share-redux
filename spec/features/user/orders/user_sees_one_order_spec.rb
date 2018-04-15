require 'rails_helper'

describe 'User' do
  context 'visits order show page' do
    it 'shows info for that order' do
      user              = create(:user)
      order             = user.orders.create!(status: 'paid')
      accessory_1       = create(:accessory)
      order_accessory_1 = accessory_1.order_accessories.create(quantity: 3, order_id: order.id)
      accessory_2       = create(:accessory)
      order_accessory_2 = accessory_2.order_accessories.create(quantity: 1, order_id: order.id)
      accessory_3       = create(:accessory)
      order_accessory_3 = accessory_3.order_accessories.create(quantity: 20, order_id: order.id)
      order_accessories = [order_accessory_1, order_accessory_2, order_accessory_3]

      visit root_path
      click_on "Login"

      fill_in 'username', with: user.username
      fill_in 'password', with: user.password
      click_on "Login"
      click_on order.id

      save_and_open_page
      expect(current_path).to eq("/orders/#{order.id}")
      order_accessories.each do |order_accessory|
        expect(page).to have_content(order_accessory.accessory.title)
        expect(page).to have_content(order_accessory.quantity)
        expect(page).to have_content(order_accessory.subtotal)
      end
      expect(page).to have_content(order.total_price)
      expect(page).to have_content(order.status)
      expect(page).to have_content(order.created_at)
    end
  end
end
