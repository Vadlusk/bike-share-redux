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
      expect(@station.num_rides_started).to eq(20)
    end
    it 'shows number of rides ended at this station' do
      expect(@station.num_rides_ended).to eq(30)
    end
    it 'shows the most frequent destination station for rides that began at this station' do
      expect(@station.frequent_destination).to eq('Good')
    end
    it 'shows the most frequent origination station for rides that ended at this station' do
      expect(@station.frequent_origination).to eq('Good')
    end
    it 'shows the date with the highest number of trips started at this station' do
      expect(@station.busiest_date).to eq('1/3/1999')
    end
    it 'shows the most frequent zip code for users starting trips at this station' do
      expect(@station.busiest_zip_code).to eq('80210')
    end
    it 'shows the bike ID most frequently starting a trip at this station' do
      expect(@station.busiest_bike).to eq(9)
    end
  end
end
