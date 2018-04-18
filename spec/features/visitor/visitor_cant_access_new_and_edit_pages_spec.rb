require 'rails_helper'

describe 'visitor goes to restricted page' do
  scenario 'tries to visit admin trip new & edit' do
    trip = create(:trip)

    visit new_admin_trip_path
    expect(page).to_not have_content("Duration")
    expect(page).to_not have_content("Start station")
    expect(page).to_not have_content("End date")

    visit edit_admin_trip_path(trip)
    expect(page).to_not have_content("Duration")
    expect(page).to_not have_content("Start station")
    expect(page).to_not have_content("End date")
  end
  scenario 'tries to visit admin trip new & edit' do
    condition = create(:condition)

    visit new_admin_condition_path
    expect(page).to_not have_content("Max temperature f")
    expect(page).to_not have_content("Min temperature f")

    visit edit_admin_condition_path(condition)
    expect(page).to_not have_content("Max temperature f")
    expect(page).to_not have_content("Min temperature f")
  end
  scenario 'tries to admin trip new & edit' do
    station = create(:station)

    visit new_admin_station_path
    expect(page).to_not have_content("Installation date")
    expect(page).to_not have_content("Dock count")
    expect(page).to_not have_content("City")

    visit edit_admin_station_path(station)
    expect(page).to_not have_content("Installation date")
    expect(page).to_not have_content("Dock count")
    expect(page).to_not have_content("City")
  end
  scenario 'tries to admin trip new & edit' do
    accessory = create(:accessory)

    visit new_admin_accessory_path
    expect(page).to_not have_content("Title")
    expect(page).to_not have_content("Description")
    expect(page).to_not have_content("Image url")

    visit edit_admin_accessory_path(accessory)
    expect(page).to_not have_content("Title")
    expect(page).to_not have_content("Description")
    expect(page).to_not have_content("Image url")
  end
end
