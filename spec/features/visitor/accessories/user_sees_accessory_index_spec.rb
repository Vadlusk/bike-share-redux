require 'rails_helper'

describe 'visitor' do
  scenario 'a visitor goes to /bike-shop and sees all accessories' do
    accessories = create_list(:accessory, 12)

    visit '/bike-shop'
    save_and_open_page

    accessories.each do |accessory|
      expect(page).to have_content(accessory.title)
      expect(page).to have_content(accessory.description)
      expect(page).to have_content(accessory.price)
      expect(page).to have_css(".accessory_image")
      expect(page).to have_button("Add to Cart")
    end
  end
end
