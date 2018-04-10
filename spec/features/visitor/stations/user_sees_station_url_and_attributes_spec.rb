require 'rails_helper'

describe 'visitor' do
  scenario 'visitor sees all station attribute' do
    station = create(:station)

    visit station_path(station)

    expect(page).to have_content(station.name)
    expect(page).to have_content(station.dock_count)
    expect(page).to have_content(station.city)
    expect(page).to have_content(station.installation_date)
    expect(page).to have_content(station.latitude)
    expect(page).to have_content(station.longitude)
  end

  scenario 'visitor sees station name in URL' do
    station = create(:station)

    visit station_path(station)

    expect(current_path).to eq("/#{station.name}")
  end
end
