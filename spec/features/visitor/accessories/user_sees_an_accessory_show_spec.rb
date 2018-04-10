require 'rails_helper'

describe 'visitor' do
  scenario 'a visitor goes to accessory show and sees the item info' do
    accessory = create(:accessory)

    visit accessory_path(accessory)

    expect(page).to have_content(accessory.title)
    expect(page).to have_content(accessory.description)
    expect(page).to have_content(accessory.price)
    expect(page).to have_css(".accessory_image")
  end

  scenario 'a visitor goes to accessory show and clicks add_to_cart' do
    skip "Waiting on cart to be built. Will need flash message in accessory#show"
    accessory = create(:accessory)

    visit accessory_path(accessory)
    click_on 'Add to Cart'

    expect(page).to have_content("You've added #{accessory.title} to your cart")
  end
end
