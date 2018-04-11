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
    accessory = create(:accessory, title: 'Seat')

    visit accessory_path(accessory)
    click_button 'Add to Cart'

    expect(current_path).to eq(accessory_path(accessory))
    expect(page).to have_content("You've added 1 #{accessory.title} to your cart")

    click_button 'Add to Cart'

    expect(page).to have_content("You've added 2 #{accessory.title}s to your cart")
  end
end
