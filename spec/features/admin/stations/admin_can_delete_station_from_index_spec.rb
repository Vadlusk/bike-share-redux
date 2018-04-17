require 'rails_helper'

describe 'admin' do
  context 'as an admin' do
    it 'sees delete button in station index' do
      create_list(:station, 10)
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit stations_path

      expect(page).to have_css(".table-buttons")
    end

    it 'does not show delete button to non-admin' do
      create_list(:station, 10)
      station = create(:station)
      trips   = create_list(:trip, 10, start_station_id: station.id, end_station_id: station.id)
      user    = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit stations_path

      expect(page).to_not have_css(".table-buttons")
    end

    it 'can delete a station by clicking button' do
      create_list(:station, 10)
      station = create(:station, name: 'Grrblllball')
      trips   = create_list(:trip, 20, start_station_id: station.id, end_station_id: station.id)
      admin   = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit stations_path
      expect(page).to have_content('Grrblllball')

      within(".station-#{station.id}") do
        find(:xpath, ".//a[i[contains(@class, 'far fa-trash-alt')]]").click
      end

      expect(current_path).to eq(stations_path)
      expect(page).to have_content("You deleted the station successfully.")
      expect(page).to_not have_content('Grrblllball')
    end

  end
end
