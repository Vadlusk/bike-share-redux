require 'rails_helper'

describe 'Visitor' do
  context 'a visitor goes to the cart page' do
    it 'increases item quantity in cart' do
      accessory1 = Accessory.create!(title: "help", description: "Bad", price: 100, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)

      visit bike_shop_path

      within('form:nth-of-type(1)') do
        click_button("Add to Cart")
      end

      visit '/cart'

      within(".table-buttons") do
        find(:xpath, ".//a[i[contains(@class, 'fas fa-plus-square')]]").click
      end

      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("$100.00 x 2 = $200.00")
      expect(page).to have_content("Total: $200.00")
      expect(current_path).to eq('/cart')
    end

    it 'decreases item quantity in cart' do
      Accessory.create!(title: "help", description: "Bad", price: 100, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)

      visit bike_shop_path

      within('form:nth-of-type(1)') do
        click_button("Add to Cart")
      end

      visit '/cart'

      within(".table-buttons") do
        find(:xpath, ".//a[i[contains(@class, 'fas fa-plus-square')]]").click
      end

      expect(page).to have_content("Quantity: 2")

      within(".table-buttons") do
        find(:xpath, ".//a[i[contains(@class, 'fas fa-minus-square')]]").click
      end

      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content("$100.00 x 1 = $100.00")
      expect(page).to have_content("Total: $100.00")
      expect(current_path).to eq('/cart')
    end

    it 'removes an item if decreased to zero' do
      Accessory.create!(title: "help", description: "Bad", price: 100, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)

      visit bike_shop_path

      within('form:nth-of-type(1)') do
        click_button("Add to Cart")
      end

      visit '/cart'

      within(".table-buttons") do
        find(:xpath, ".//a[i[contains(@class, 'fas fa-minus-square')]]").click
      end

      expect(page).to have_content("Successfully removed help from your cart")
      expect(page).to have_link("help")
      expect(page).to_not have_content("$100.00 x 1 = $100.00")
      expect(current_path).to eq('/cart')
    end
  end
end
