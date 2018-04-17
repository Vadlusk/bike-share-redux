require 'rails_helper'

describe 'visitor' do
  scenario 'visitor sees all stations on stations index' do
    station_1 = create(:station)
    station_2 = create(:station)
    station_3 = create(:station)
    trips     = create_list(:trip, 10, start_station_id: station_1.id, end_station_id: station_2.id)
    trip      = create(:trip, start_station_id: station_3.id)
    stations  = [station_1, station_2, station_3]

    visit stations_path

    stations.each do |station|
      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date.strftime("%B %d, %Y"))
    end
  end
end
