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
      expect(page).to have_content("Add to Cart")
    end
  end
  scenario 'a visitor goes to /bike-shop and adds items to their cart' do
    accessory = create(:accessory)

    visit '/bike-shop'

    click_on("Add to Cart")

    expect(page).to have_content("You've added 1 #{accessory.title} to your cart")

    within('.cart') do
      expect(page).to have_content("(1)")
    end

    click_on("Add to Cart")

    within('.cart') do
      expect(page).to have_content("(2)")
    end
  end
end
