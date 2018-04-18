require 'rails_helper'

describe 'visitor goes to restricted page' do
  scenario 'tries to go to order page' do
    order = create(:order)
    accessory1 = create(:accessory)
    accessory2 = create(:accessory)
    accessory3 = create(:accessory)
    create(:order_accessory, accessory_id: accessory1.id, order_id: order.id)
    create(:order_accessory, accessory_id: accessory2.id, order_id: order.id)
    create(:order_accessory, accessory_id: accessory3.id, order_id: order.id)

    visit order_path(order)

    expect(page).to_not have_content(accessory1.title)
    expect(page).to_not have_content(accessory2.title)
    expect(page).to_not have_content(accessory3.title)
  end
  scenario 'tries to go to order page' do
    user = create(:user)

    visit edit_user_path(user)
    expect(page).to_not have_content("Username")
    expect(page).to_not have_content("Email")
    expect(page).to_not have_content("Password")
  end
end
