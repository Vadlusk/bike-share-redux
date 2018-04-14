require 'rails_helper'

describe 'Admin' do
  context 'edits a trip' do
    it 'is possible with correct use of fields' do
      admin = create(:admin)
      trip  = create(:trip)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit edit_admin_trip_path(trip)

      fill_in 'trip[duration]', with: 100
      fill_in 'trip[start_date]', with: '01/01/2003'
      fill_in 'trip[start_station_name]', with: 'station name'
      fill_in 'trip[start_station_id]', with: 900
      fill_in 'trip[end_date]', with: '03/01/2003'
      fill_in 'trip[end_station_name]', with: 'end station name'
      fill_in 'trip[end_station_id]', with: 1000
      fill_in 'trip[bike_id]', with: 974
      select 'subscriber', from: 'trip[subscription_type]'
      fill_in 'trip[zip_code]', with: 80210
      click_on 'Update Trip'

      expect(current_path).to eq(trip_path(trip))
      expect(page).to have_content('You successfully updated this trip')
      expect(page).to have_content('100')
      expect(page).to have_content('January 01, 2003')
      expect(page).to have_content('station name')
      expect(page).to have_content('900')
      expect(page).to have_content('January 03, 2003')
      expect(page).to have_content('end station name')
      expect(page).to have_content('1000')
      expect(page).to have_content('974')
      expect(page).to have_content('subscriber')
      expect(page).to have_content('80210')
      expect(page).to_not have_content(trip.duration)
      expect(page).to_not have_content(trip.start_date)
      expect(page).to_not have_content(trip.start_station_name)
      expect(page).to_not have_content(trip.start_station_id)
      expect(page).to_not have_content(trip.end_date)
      expect(page).to_not have_content(trip.end_station_name)
      expect(page).to_not have_content(trip.end_station_id)
      expect(page).to_not have_content(trip.bike_id)
      expect(page).to_not have_content(trip.subscription_type)
      expect(page).to_not have_content(trip.zip_code)
    end
    it 'is not possible with incorrect use of fields' do
      admin = create(:admin)
      trip  = create(:trip)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit edit_admin_trip_path(trip)

      fill_in 'trip[duration]', with: 100
      fill_in 'trip[start_date]', with: ''
      fill_in 'trip[start_station_name]', with: 'station name'
      fill_in 'trip[start_station_id]', with: ''
      fill_in 'trip[end_date]', with: ''
      fill_in 'trip[end_station_name]', with: 'end station name'
      fill_in 'trip[end_station_id]', with: 1000
      fill_in 'trip[bike_id]', with: 974
      select 'subscriber', from: 'trip[subscription_type]'
      fill_in 'trip[zip_code]', with: 80210
      click_on 'Update Trip'

      expect(current_path).to eq(admin_trip_path(trip))
      expect(page).to have_content('Failed to update trip')
    end
  end
end
