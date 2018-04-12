require 'rails_helper'

describe 'visitor' do
  scenario 'visitor sees all station attribute' do
    station = create(:station)

    visit station_path(station)

    expect(page).to have_content(station.name)
    expect(page).to have_content(station.dock_count)
    expect(page).to have_content(station.city)
    expect(page).to have_content(station.built)
    expect(page).to have_content(station.lat)
    expect(page).to have_content(station.long)
  end

  scenario 'visitor sees station name in URL' do
    station = create(:station)

    visit station_path(station)

    expect(current_path).to eq("/stations/#{station.slug}")
    expect(page).to have_content(station.name)
    expect(page).to have_content(station.dock_count)
    expect(page).to have_content(station.city)
    expect(page).to have_content(station.built)
  end
end
