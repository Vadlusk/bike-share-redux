require 'rails_helper'

describe 'Admin' do
  context 'deletes a trip' do
    scenario 'from the trip index' do
      admin = create(:admin)
      trip  = create(:trip)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit trips_path

      within(".table-buttons") do
        find(:xpath, ".//a[i[contains(@class, 'far fa-trash-alt')]]").click
      end
      save_and_open_page

      expect(current_path).to eq(trips_path)
      expect(page).to have_content('Successfully deleted trip')
      expect(page).to_not have_content(trip.duration)
      expect(page).to_not have_content(trip.start_date)
      expect(page).to_not have_content(trip.start_station_id)
      expect(page).to_not have_content(trip.start_station_name)
      expect(page).to_not have_content(trip.end_date)
      expect(page).to_not have_content(trip.end_station_id)
      expect(page).to_not have_content(trip.end_station_name)
    end
  end
end
