require 'rails_helper'

describe 'visitor' do
  scenario 'visitor sees all stations on stations index' do
    station_1 = create(:station)
    station_2 = create(:station)
    station_3 = create(:station)

    visit stations_path

    expect(page).to have_content(station_1.name)
    expect(page).to have_content(station_2.name)
    expect(page).to have_content(station_1.dock_count)
    expect(page).to have_content(station_1.city)
    expect(page).to have_content(station_1.built)
  end
end
