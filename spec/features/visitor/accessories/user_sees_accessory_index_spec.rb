require 'rails_helper'

describe 'visitor' do
  scenario 'a visitor goes to /bike-shop and sees all accessories' do
    accessories = create_list(:accessory, 12)

    visit '/bike-shop'

    accessories.each do |accessory|
      expect(page).to have_content(accessory.title)
      expect(page).to have_content(accessory.description)
      expect(page).to have_content(accessory.price)
      expect(page).to have_css(".accessory_image")
      expect(page).to have_button("Add to Cart")
    end
  end
  scenario 'a visitor goes to /bike-shop and adds items to their cart' do
    accessories = create_list(:accessory, 12)

    visit '/bike-shop'
    save_and_open_page

    within('form:nth-of-type(2)') do
      click_button("Add to Cart")
    end

    expect(page).to have_content("You've added 1 #{accessories[1].title} to your cart")

    within('.cart') do
      expect(page).to have_content("(1)")
    end

    within('form:nth-of-type(5)') do
      click_button("Add to Cart")
    end

    within('.cart') do
      expect(page).to have_content("(2)")
    end
  end
end
