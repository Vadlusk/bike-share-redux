require 'rails_helper'

describe 'visitor' do
  scenario 'a visitor goes to accessory show and sees the item info' do
    accessory = create(:accessory)

    visit accessory_path(accessory)

    expect(page).to have_content(accessory.title)
    expect(page).to have_content(accessory.description)
    expect(page).to have_content(accessory.price)
  end
end
