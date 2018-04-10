require 'rails_helper'

describe 'visitor' do
  scenario 'visitor sees all stations on stations index' do
    stations = create_list(:trip, 1)

    visit stations_path

    stations.each do |station|
      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date)
      expect(page).to have_content(station.latitude)
      expect(page).to have_content(station.longitude)
    end
  end
end
