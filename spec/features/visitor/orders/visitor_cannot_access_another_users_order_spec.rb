require 'rails_helper'

describe 'user sees all conditions' do
  scenario 'and all their attributes' do
    order = create(:order)
    accessory1 = create(:accessory)
    accessory2 = create(:accessory)
    accessory3 = create(:accessory)
    create(:order_accessory, accessory_id: accessory1.id, order_id: order.id)
    create(:order_accessory, accessory_id: accessory2.id, order_id: order.id)
    create(:order_accessory, accessory_id: accessory3.id, order_id: order.id)

    visit order_path(order)
    save_and_open_page

    expect(page).to_not have_content(accessory1.title)
    expect(page).to_not have_content(accessory2.title)
    expect(page).to_not have_content(accessory3.title)
  end
end
