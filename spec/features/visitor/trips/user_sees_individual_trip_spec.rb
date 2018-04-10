require 'rails_helper'

describe 'Visitor' do
  scenario 'A visitor goes to trip show and sees all that trips attributes' do
    trip = create(:trip)

    visit trip_path(trip)

    expect(page).to have_content(trip.duration)
    expect(page).to have_content(trip.start_date)
    expect(page).to have_content(trip.start_station_name)
    expect(page).to have_content(trip.start_station_id)
    expect(page).to have_content(trip.end_date)
    expect(page).to have_content(trip.end_station_name)
    expect(page).to have_content(trip.end_station_id)
    expect(page).to have_content(trip.bike_id)
    expect(page).to have_content(trip.subscription_type)
    expect(page).to have_content(trip.zip_code)
  end
end
