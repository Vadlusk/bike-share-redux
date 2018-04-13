require 'rails_helper'

describe Trip do
  describe 'Field validations' do
    context 'invalid attributes' do
      it 'is invalid without a zip code' do
        trip = Trip.create(
          duration: 1000,
          start_date: Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M'),
          start_station_name: '2nd at South Park',
          start_station_id: 100,
          end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'),
          end_station_name: '2nd at South Park',
          end_station_id: 100,
          bike_id: 1000,
          subscription_type: 'Subscriber',
          zip_code: ''
        )

        expect(trip).to_not be_valid
      end
    end
    context 'valid attributes' do
      it 'is valid with all attributes' do
        trip = Trip.create(
          duration: 1000,
          start_date: Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M'),
          start_station_name: '2nd at South Park',
          start_station_id: 100,
          end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'),
          end_station_name: '2nd at South Park',
          end_station_id: 100,
          bike_id: 1000,
          subscription_type: 'Subscriber',
          zip_code: '94703'
        )

        expect(trip).to be_valid
      end
    end
  end
  describe 'Analysis methods' do
    context 'average duration' do
      it 'returns the average duration of all rides' do
        trips = create_list(:trip, 10)

        average = trips.map(&:duration).sum/trips.count

        expect(Trip.average_duration).to eq(average)
      end
      it 'returns the longest ride' do
        trips = create_list(:trip, 10)

        longest = trips.max_by(&:duration)

        expect(Trip.longest_ride).to eq(longest)
      end
      it 'returns the shortest ride' do
        trips = create_list(:trip, 10)

        shortest = trips.min_by(&:duration)

        expect(Trip.shortest_ride).to eq(shortest)
      end
    end
  end
end
