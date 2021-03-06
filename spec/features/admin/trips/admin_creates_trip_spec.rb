require 'rails_helper'

describe 'Admin' do
  scenario 'creates a new trip' do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_trip_path

    fill_in 'trip[duration]', with: 100
    fill_in 'trip[start_date]', with: '01/01/2003'
    fill_in 'trip[start_station_name]', with: 'station name'
    fill_in 'trip[start_station_id]', with: 900
    fill_in 'trip[end_date]', with: '01/03/2003'
    fill_in 'trip[end_station_name]', with: 'end station name'
    fill_in 'trip[end_station_id]', with: 1000
    fill_in 'trip[bike_id]', with: 974
    select 'subscriber', from: 'trip[subscription_type]'
    fill_in 'trip[zip_code]', with: 80210
    click_on 'Create Trip'

    expect(current_path).to eq(trip_path(Trip.last.id))
    expect(page).to have_content('You successfully created this trip')
    expect(page).to have_content('100')
    expect(page).to have_content('January 01, 2003')
    expect(page).to have_content('station name')
    expect(page).to have_content('900')
    expect(page).to have_content('January 01, 2003')
    expect(page).to have_content('end station name')
    expect(page).to have_content('1000')
    expect(page).to have_content('974')
    expect(page).to have_content('subscriber')
    expect(page).to have_content('80210')
  end
  scenario 'cannot create a new trip without every field' do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_trip_path

    fill_in 'trip[duration]', with: ''
    fill_in 'trip[start_date]', with: '01/01/2003'
    fill_in 'trip[start_station_name]', with: 'station name'
    fill_in 'trip[start_station_id]', with: 900
    fill_in 'trip[end_date]', with: '01/03/2003'
    fill_in 'trip[end_station_name]', with: 'end station name'
    fill_in 'trip[end_station_id]', with: 1000
    fill_in 'trip[bike_id]', with: 974
    select 'subscriber', from: 'trip[subscription_type]'
    fill_in 'trip[zip_code]', with: 80210
    click_on 'Create Trip'

    expect(current_path).to eq(new_admin_trip_path)
    expect(page).to have_content('Failed to create new trip')
  end
end
