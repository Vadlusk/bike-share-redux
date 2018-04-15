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
      it 'returns the station with the most rides as a starting place' do
        create_list(:station, 10)
        trip1 = Trip.create(duration: 1000, start_date: Date.strptime('1/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 1, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip2 = Trip.create(duration: 1000, start_date: Date.strptime('2/27/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 2, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip3 = Trip.create(duration: 1000, start_date: Date.strptime('3/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 3, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip4 = Trip.create(duration: 1000, start_date: Date.strptime('4/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 4, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip5 = Trip.create(duration: 1000, start_date: Date.strptime('5/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 5, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip6 = Trip.create(duration: 1000, start_date: Date.strptime('6/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 6, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip7 = Trip.create(duration: 1000, start_date: Date.strptime('7/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 1, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip8 = Trip.create(duration: 1000, start_date: Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 1, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip9 = Trip.create(duration: 1000, start_date: Date.strptime('9/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 2, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip10 = Trip.create(duration: 1000, start_date: Date.strptime('10/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 7, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trips = [trip1, trip2, trip3, trip4, trip5, trip6, trip7, trip8, trip9, trip10]


        grouped_by_station = trips.group_by(&:start_station_id)

        busiest =
          grouped_by_station.max_by do |station|
            station[1].count
          end
        busiest_station = Station.find(busiest[0])

        expect(Trip.busiest_starting_station).to eq(busiest_station)
      end
      it 'returns the station with the most rides as ending place' do
        create_list(:station, 10)
        trip1 = Trip.create(duration: 1000, start_date: Date.strptime('1/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 1, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 1, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip2 = Trip.create(duration: 1000, start_date: Date.strptime('2/27/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 2, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 1, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip3 = Trip.create(duration: 1000, start_date: Date.strptime('3/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 3, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 1, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip4 = Trip.create(duration: 1000, start_date: Date.strptime('4/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 4, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 2, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip5 = Trip.create(duration: 1000, start_date: Date.strptime('5/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 5, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 4, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip6 = Trip.create(duration: 1000, start_date: Date.strptime('6/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 6, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 5, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip7 = Trip.create(duration: 1000, start_date: Date.strptime('7/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 1, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 6, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip8 = Trip.create(duration: 1000, start_date: Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 1, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 7, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip9 = Trip.create(duration: 1000, start_date: Date.strptime('9/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 2, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 8, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip10 = Trip.create(duration: 1000, start_date: Date.strptime('10/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 7, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 9, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trips = [trip1, trip2, trip3, trip4, trip5, trip6, trip7, trip8, trip9, trip10]

        grouped_by_station = trips.group_by(&:end_station_id)

        busiest =
          grouped_by_station.max_by do |station|
            station[1].count
          end
        busiest_station = Station.find(busiest[0])

        expect(Trip.busiest_ending_station).to eq(busiest_station)
      end
      it 'returns Month by Month breakdown of number of rides with subtotals for each year' do
        trip1 = Trip.create(duration: 1000, start_date: Date.strptime('1/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip2 = Trip.create(duration: 1000, start_date: Date.strptime('2/27/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip3 = Trip.create(duration: 1000, start_date: Date.strptime('3/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip4 = Trip.create(duration: 1000, start_date: Date.strptime('4/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip5 = Trip.create(duration: 1000, start_date: Date.strptime('5/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip6 = Trip.create(duration: 1000, start_date: Date.strptime('6/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip7 = Trip.create(duration: 1000, start_date: Date.strptime('7/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip8 = Trip.create(duration: 1000, start_date: Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip9 = Trip.create(duration: 1000, start_date: Date.strptime('9/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip10 = Trip.create(duration: 1000, start_date: Date.strptime('10/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip11 = Trip.create(duration: 1000, start_date: Date.strptime('11/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip12 = Trip.create(duration: 1000, start_date: Date.strptime('12/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip13 = Trip.create(duration: 1000, start_date: Date.strptime('1/29/2014 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trips = [trip1, trip2, trip3, trip4, trip5, trip6, trip7, trip8, trip9, trip10, trip11, trip12, trip13]

        grouped_by_month = trips.group_by do |each_trip|
          each_trip.start_date.month
        end

        grouped_by_year = trips.group_by do |each_trip|
          each_trip.start_date.year
        end

        jan_ride_count = grouped_by_month[1].count
        june_ride_count = grouped_by_month[6].count
        ride_count_2013 = grouped_by_year[2013].count
        ride_count_2014 = grouped_by_year[2014].count

        expect(Trip.monthly_ride_count[1.0]).to eq(jan_ride_count)
        expect(Trip.monthly_ride_count[6.0]).to eq(june_ride_count)
        expect(Trip.yearly_ride_count[2013.0]).to eq(ride_count_2013)
        expect(Trip.yearly_ride_count[2014.0]).to eq(ride_count_2014)
      end
      it 'returns the Most ridden bike with total number of rides for that bike' do
        trip1 = Trip.create(duration: 1000, start_date: Date.strptime('1/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1, subscription_type: 'Subscriber', zip_code: '94703')
        trip2 = Trip.create(duration: 1000, start_date: Date.strptime('2/27/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1, subscription_type: 'Subscriber', zip_code: '94703')
        trip3 = Trip.create(duration: 1000, start_date: Date.strptime('3/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1, subscription_type: 'Subscriber', zip_code: '94703')
        trip4 = Trip.create(duration: 1000, start_date: Date.strptime('4/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1, subscription_type: 'Subscriber', zip_code: '94703')
        trip5 = Trip.create(duration: 1000, start_date: Date.strptime('5/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 2, subscription_type: 'Subscriber', zip_code: '94703')
        trip6 = Trip.create(duration: 1000, start_date: Date.strptime('6/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 2, subscription_type: 'Subscriber', zip_code: '94703')
        trip7 = Trip.create(duration: 1000, start_date: Date.strptime('6/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 3, subscription_type: 'Subscriber', zip_code: '94703')
        trip8 = Trip.create(duration: 1000, start_date: Date.strptime('7/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 3, subscription_type: 'Subscriber', zip_code: '94703')
        trips = [trip1, trip2, trip3, trip4, trip5, trip6, trip7, trip8]

        grouped_by_bike = trips.group_by(&:bike_id)
        maxed_bike = grouped_by_bike.max_by do |bike|
          bike[1].count
        end

        expect(Trip.most_popular_bike.bike_id).to eq(maxed_bike[0])
        expect(Trip.most_popular_bike.count).to eq(maxed_bike[1].count)
      end
      it 'returns the least ridden bike with total number of rides for that bike' do
        trip1 = Trip.create(duration: 1000, start_date: Date.strptime('1/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1, subscription_type: 'Subscriber', zip_code: '94703')
        trip2 = Trip.create(duration: 1000, start_date: Date.strptime('2/27/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1, subscription_type: 'Subscriber', zip_code: '94703')
        trip3 = Trip.create(duration: 1000, start_date: Date.strptime('3/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1, subscription_type: 'Subscriber', zip_code: '94703')
        trip4 = Trip.create(duration: 1000, start_date: Date.strptime('4/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 2, subscription_type: 'Subscriber', zip_code: '94703')
        trip5 = Trip.create(duration: 1000, start_date: Date.strptime('5/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 2, subscription_type: 'Subscriber', zip_code: '94703')
        trip6 = Trip.create(duration: 1000, start_date: Date.strptime('6/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 2, subscription_type: 'Subscriber', zip_code: '94703')
        trip7 = Trip.create(duration: 1000, start_date: Date.strptime('6/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 3, subscription_type: 'Subscriber', zip_code: '94703')
        trip8 = Trip.create(duration: 1000, start_date: Date.strptime('7/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 3, subscription_type: 'Subscriber', zip_code: '94703')
        trips = [trip1, trip2, trip3, trip4, trip5, trip6, trip7, trip8]

        grouped_by_bike = trips.group_by(&:bike_id)
        min_bike = grouped_by_bike.min_by do |bike|
          bike[1].count
        end

        expect(Trip.least_popular_bike.bike_id).to eq(min_bike[0])
        expect(Trip.least_popular_bike.count).to eq(min_bike[1].count)
      end
      it 'returns the User subscription type breakout with both count and percentage' do
        trips = create_list(:trip, 100)

        # Ruby version
        grouped_by_sub = trips.group_by(&:subscription_type)
        ruby_subscriber_count = grouped_by_sub['Subscriber'].count
        ruby_customer_count = grouped_by_sub['Customer'].count
        ruby_subscription_percent = ruby_subscriber_count / trips.count.to_f
        ruby_customer_percent = ruby_customer_count / trips.count.to_f
        # ----

        # ActiveRecord version
        ar_subscriber = Trip.user_sub_type.find_by(subscription_type: "Subscriber")
        ar_customer = Trip.user_sub_type.find_by(subscription_type: "Customer")
        # ----

        expect(ar_subscriber.count).to eq(ruby_subscriber_count)
        expect(ar_customer.count).to eq(ruby_customer_count)
        expect(ar_subscriber.count / trips.count.to_f).to eq(ruby_subscription_percent)
        expect(ar_customer.count / trips.count.to_f).to eq(ruby_customer_percent)
      end
      it 'returns the Single date with the highest number of trips with a count of those trips' do
        trip1 = Trip.create(duration: 1000, start_date: Date.strptime('1/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip2 = Trip.create(duration: 1000, start_date: Date.strptime('1/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip3 = Trip.create(duration: 1000, start_date: Date.strptime('2/27/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip4 = Trip.create(duration: 1000, start_date: Date.strptime('4/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trips = [trip1, trip2, trip3, trip4]

        # Ruby version
        grouped_by_date = trips.group_by do |each_trip|
          each_trip.start_date.to_date
        end

        busiest = grouped_by_date.max_by do |date|
          date[1].count
        end
        # ----

        expect(Trip.busiest_date.date).to eq(busiest[0])
        expect(Trip.busiest_date.count).to eq(busiest[1].count)
      end
      it 'returns the Single date with the lowest number of trips with a count of those trips' do
        trip1 = Trip.create(duration: 1000, start_date: Date.strptime('1/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip2 = Trip.create(duration: 1000, start_date: Date.strptime('1/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip3 = Trip.create(duration: 1000, start_date: Date.strptime('2/27/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip4 = Trip.create(duration: 1000, start_date: Date.strptime('4/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip5 = Trip.create(duration: 1000, start_date: Date.strptime('4/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trip6 = Trip.create(duration: 1000, start_date: Date.strptime('4/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
        trips = [trip1, trip2, trip3, trip4, trip5, trip6]

        # Ruby version
        grouped_by_date = trips.group_by do |each_trip|
          each_trip.start_date.to_date
        end

        slowest = grouped_by_date.min_by do |date|
          date[1].count
        end
        # ----

        expect(Trip.slowest_date.date).to eq(slowest[0])
        expect(Trip.slowest_date.count).to eq(slowest[1].count)
      end
    end
  end
end
