require 'rails_helper'

describe 'Visitor' do
  context 'a visitor goes to the cart page' do
    it 'displays all added accessories' do
      cart = Cart.new(nil)
      accessories = create_list(:accessory, 10)

      visit bike_shop_path

      within('form:nth-of-type(1)') do
        click_button("Add to Cart")
      end
      within('form:nth-of-type(2)') do
        click_button("Add to Cart")
      end
      within('form:nth-of-type(3)') do
        click_button("Add to Cart")
      end
      within('form:nth-of-type(4)') do
        click_button("Add to Cart")
      end
      within('form:nth-of-type(5)') do
        click_button("Add to Cart")
      end

      visit cart_path

      accessories.each do |accessory|
        expect(page).to have_content(accessory.title)
        expect(page).to have_content(accessory.price)
        expect(page).to have_content(accessory.quantity)
        expect(page).to have_content(accessory.quantity)
      end
      expect(page).to have_content("Total: #{cart.total_price}")
    end
  end
end
