require 'rails_helper'


describe 'User' do
  before :each do
    user     = create(:user)
    @station = create(:station)
    trips_1  = create_list(:trip, 18, start_station_id: @station.id, end_station_name: 'Good', start_date:'1/3/1999', zip_code: '80210', bike_id: 9)
    trips_2  = create_list(:trip, 2, start_station_id: @station.id, end_station_name: 'Bad')
    trips_3  = create_list(:trip, 17, end_station_id: @station.id, start_station_name: 'Good')
    trips_4  = create_list(:trip, 13, end_station_id: @station.id, start_station_name: 'Bad')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit station_path(@station)
  end
  context 'visits a station show page' do
    it 'shows number of rides started at this station' do
      expect(page).to have_content("Rides started at this station: #{@station.num_rides_started}")
    end
    it 'shows number of rides ended at this station' do
      expect(page).to have_content("Rides ended at this station: #{@station.num_rides_ended}")
    end
    it 'shows the most frequent destination station for rides that began at this station' do
      expect(page).to have_content("Most frequent destination from this station: #{@station.frequent_destination}")
    end
    it 'shows the most frequent origination station for rides that ended at this station' do
      expect(page).to have_content("Most frequent origination to this station: #{@station.frequent_origination}")
    end
    it 'shows the date with the highest number of trips started at this station' do
      expect(page).to have_content("Busiest date: #{@station.busiest_date}")
    end
    it 'shows the most frequent zip code for users starting trips at this station' do
      expect(page).to have_content("Most frequent zip code for users at this station: #{@station.busiest_zip_code}")
    end
    it 'shows the bike ID most frequently starting a trip at this station' do
      expect(page).to have_content("Busiest bike id for this station: #{@station.busiest_bike}")
    end
  end
end
