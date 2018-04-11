require 'rails_helper'

describe 'visitor' do
  scenario 'a visitor goes to a retired accessory show page' do
    accessory = Accessory.create(title: 'Retired Item',
                                 description: 'An item which can no longer be purchased',
                                 price: 50.50,
                                 image_url: "http://www.iwantthatsign.com/WebRoot/BT2/Shops/BT4029/4B92/6F4B/DA52/7B6F/97F3/0A0A/33E8/E557/retired-and-lovin-it-2011.jpg",
                                 status: 1)

    visit accessory_path(accessory)

    expect(page).to have_content('Accessory Retired')
    expect(page).to have_content(accessory.title)
    expect(page).to have_content(accessory.description)
    expect(page).to have_content(accessory.price)
    expect(page).to have_css(".accessory_image")
    expect(page).to_not have_content("Add to Cart")
  end
end
