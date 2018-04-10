require 'rails_helper'

describe 'Visitor' do
  scenario 'A visitor goes to trip index and sees all trips' do
    trips = create_list(:trip, 3)

    visit trips_path

    trips.each do |trip|
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
  scenario 'A visitor goes to trip index and sees trips over 30 paginated' do
    trips = create_list(:trip, 35)

    visit trips_path

    expect(page).to have_content("#{trips[0].duration} #{trips[0].start_date} #{trips[0].start_station_name}")
    expect(page).to_not have_content("#{trips[33].duration} #{trips[33].start_date} #{trips[33].start_station_name}")
    expect(page).to have_content('← Previous 1 2 Next →')
  end
end
