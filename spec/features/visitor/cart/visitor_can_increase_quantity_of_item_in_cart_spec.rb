require 'rails_helper'

describe 'Visitor' do
  context 'a visitor goes to the cart page' do
    it 'increases item quantity in cart' do
      accessories = create_list(:accessory, 5)

      visit bike_shop_path


      within('form:nth-of-type(1)') do
        click_button("Add to Cart")
      end

      visit '/cart'

      fill_in 'quantity', with: 10

      expect(page).to have_content("Quantity: 10")
      expect(page).to have_content("$100.00 x 10 = $1000.00")
      expect(page).to have_content("$200.00")
      expect(current_path).to eq("/cart")
    end
  end

end
