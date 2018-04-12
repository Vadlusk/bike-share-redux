require 'rails_helper'

describe 'Visitor' do
  context 'a visitor goes to the cart page' do
    it 'removes item from cart' do
      accessories = create_list(:accessory, 5)

      visit bike_shop_path


      within('form:nth-of-type(1)') do
        click_button("Add to Cart")
      end

      visit '/cart'

      fill_in 'quantity', with: 10

      expect(page).to have_content("Quantity: 10")
      expect(page).to_not have_content(accessories[0].description)

      click_on("#{accessories[0].title}")

      expect(current_path).to eq(accessory_path(accessories[0]))
    end
  end

end
