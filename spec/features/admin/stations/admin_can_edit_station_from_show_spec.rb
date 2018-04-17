require 'rails_helper'

describe 'admin' do
  context 'as an admin' do
    it 'sees edit button in station show' do
      station = create(:station)
      admin   = create(:admin)
      trips   = create_list(:trip, 10, start_station_id: station.id, end_station_id: station.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit station_path(station)

      expect(page).to have_css(".card-buttons")
    end
    it 'does not show edit button to visitor on station show' do
      station = create(:station)
      user    = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit station_path(station)

      expect(page).to_not have_css(".card-buttons")
    end

    it 'does not show edit button to non-admin on station show' do
      station = create(:station)
      user    = create(:user)
      trips   = create_list(:trip, 10, start_station_id: station.id, end_station_id: station.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit station_path(station)

      expect(page).to_not have_css(".table-buttons")
    end
    it 'admin can get to station edit page by clicking button' do
      station = create(:station)
      admin   = create(:admin)
      trips   = create_list(:trip, 10, start_station_id: station.id, end_station_id: station.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit station_path(station)
      find(:xpath, ".//a[i[contains(@class, 'fas fa-edit')]]").click

      expect(current_path).to eq(edit_admin_station_path(station))
    end
  end
end
