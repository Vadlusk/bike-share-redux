require 'rails_helper'

describe Station do

  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:dock_count)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:installation_date)}
    it {should validate_presence_of(:lat)}
    it {should validate_presence_of(:long)}
    it { should validate_inclusion_of(:lat).in_range(-90..90) }
    it { should validate_inclusion_of(:long).in_range(-180..180) }
  end

  describe 'Field validations' do
    context 'invalid attributes' do
      it 'is invalid without a name' do
        station = Station.create(
          name: '',
          dock_count: 30,
          city: 'San Jose',
          installation_date: Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M'),
          lat: 90,
          long: 180
        )

        expect(station).to_not be_valid
      end
      it 'is invalid without a dock count' do
        station = Station.create(
          name: 'Station',
          dock_count: '',
          city: 'San Jose',
          installation_date: Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M'),
          lat: 90,
          long: 180
        )

        expect(station).to_not be_valid
      end
      it 'is invalid without a city' do
        station = Station.create(
          name: 'Station',
          dock_count: 30,
          city: '',
          installation_date: Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M'),
          lat: 90,
          long: 180
        )

        expect(station).to_not be_valid
      end
      it 'is invalid without an installation date' do
        station = Station.create(
          name: 'Station',
          dock_count: 30,
          city: 'San Jose',
          installation_date: '',
          lat: 90,
          long: 180
        )

        expect(station).to_not be_valid
      end
      it 'is invalid without lat' do
        station = Station.create(
          name: 'Station',
          dock_count: 30,
          city: 'San Jose',
          installation_date: Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M'),
          lat: '',
          long: 180
        )

        expect(station).to_not be_valid
      end
      it 'is invalid without long' do
        station = Station.create(
          name: 'Station',
          dock_count: 30,
          city: 'San Jose',
          installation_date: Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M'),
          lat: 90,
          long: ''
        )

        expect(station).to_not be_valid
      end
    end
    context 'valid attributes' do
      it 'is valid with all attributes' do
        station = Station.create(
          name: 'Station',
          dock_count: 30,
          city: 'San Jose',
          installation_date: Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M'),
          lat: 90,
          long: 180,
        )

        expect(station).to be_valid
      end
    end
  end
  describe 'instance methods' do
    describe '#generate_slug' do
      it 'parameterizes the name' do
        station = create(:station)

        expect(station.slug).to eq(station.name.parameterize)
      end
    end
    describe '#to_param' do
      it 'uses slug as param instead of id' do
        station = create(:station)

        expect(station.to_param).to eq(station.slug)
      end
    end
    describe '#num_rides_started' do
      it 'counts the number of rides started at this station' do
        station = create(:station)
        trips_1 = create_list(:trip, 18, start_station_id: station.id)
        trips_2 = create_list(:trip, 2, start_station_id: station.id)

        expect(station.num_rides_started).to eq(20)
      end
    end
    describe '#num_rides_ended' do
      it 'counts the number of rides ended at this station' do
        station = create(:station)
        trips_1 = create_list(:trip, 18, end_station_id: station.id)
        trips_2 = create_list(:trip, 2, end_station_id: station.id)

        expect(station.num_rides_ended).to eq(20)
      end
    end
    describe '#frequent_destination' do
      it 'shows the most frequent destination station for rides that began at this station' do
        station = create(:station)
        trips_1 = create_list(:trip, 18, start_station_id: station.id, end_station_name: 'Good')
        trips_2 = create_list(:trip, 2, start_station_id: station.id, end_station_name: 'Bad')

        expect(station.frequent_destination).to eq('Good')
      end
    end
    describe '#frequent_origination' do
      it 'shows the most frequent origination station for rides that ended at this station' do
        station = create(:station)
        trips_1 = create_list(:trip, 18, end_station_id: station.id, start_station_name: 'Good')
        trips_2 = create_list(:trip, 2, end_station_id: station.id, start_station_name: 'Bad')

        expect(station.frequent_origination).to eq('Good')
      end
    end
    describe '#busiest_date' do
      it 'shows the date with the highest number of trips started at this station' do
        station = create(:station)
        trips_1 = create_list(:trip, 18, start_station_id: station.id, start_date: '1/1/2009')
        trips_2 = create_list(:trip, 2, start_station_id: station.id, start_date: '1/2/2008')

        expect(station.busiest_date).to eq('1/1/2009')
      end
    end
    describe '#busiest_zip_code' do
      it 'shows the most frequent zip code for users starting trips at this station' do
        station = create(:station)
        trips_1 = create_list(:trip, 18, start_station_id: station.id, zip_code: '12345')
        trips_2 = create_list(:trip, 2, start_station_id: station.id, zip_code: '11111')

        expect(station.busiest_zip_code).to eq(12345)
      end
    end
    describe '#busiest_bike' do
      it 'shows the bike ID most frequently starting a trip at this station' do
        station = create(:station)
        trips_1 = create_list(:trip, 18, start_station_id: station.id, bike_id: 5)
        trips_2 = create_list(:trip, 2, start_station_id: station.id, bike_id: 1)

        expect(station.busiest_bike).to eq(5)
      end
    end
  end
  describe 'class methods' do
    describe '#total_stations' do
      it 'returns the count of stations' do
        create_list(:station, 12)

        expect(Station.total_stations).to eq(12)
      end
    end
    describe '#average_bikes' do
      it 'returns the average bikes per station' do
        create_list(:station, 12)

        expect(Station.average_bikes).to eq((Station.average(:dock_count)).round(2))
      end
    end
    describe '#most_bikes' do
      it 'returns the most bikes at any station' do
        create_list(:station, 12)

        expect(Station.most_bikes).to eq(Station.maximum(:dock_count))
      end
    end
    describe '#fewest_bikes' do
      it 'returns the fewest bikes at any station' do
        create_list(:station, 12)

        expect(Station.fewest_bikes).to eq(Station.minimum(:dock_count))
      end
    end
    describe '#most_station' do
      it 'returns the  station with the most bikes' do
        create_list(:station, 12)
        station = create(:station, dock_count: 31)

        expect(Station.most_station).to eq([station])
      end
    end
    describe '#most_station' do
      it 'can return multiple stations if they are tied for most bikes' do
        create_list(:station, 12)
        station1 = create(:station, name: 'a station', dock_count: 31)
        station2 = create(:station, name: 'b station', dock_count: 31)

        expect(Station.most_station).to eq([station1, station2])
      end
    end
    describe '#fewest_station' do
      it 'returns the  station with the fewest bikes' do
        create_list(:station, 12)
        station = create(:station, dock_count: 0)

        expect(Station.fewest_station).to eq([station])
      end
    end
    describe '#fewest_station' do
      it 'can return multiple stations if they are tied for fewest bikes' do
        create_list(:station, 12)
        station1 = create(:station, name: 'a station', dock_count: 0)
        station2 = create(:station, name: 'b station', dock_count: 0)

        expect(Station.fewest_station).to eq([station1, station2])
      end
    end
    describe '#newest_station' do
      it 'returns the station installed most recently' do
        create_list(:station, 12)
        station = create(:station, installation_date: '2020-01-30')

        expect(Station.newest_station).to eq(station)
      end
    end
    describe '#oldest_station' do
      it 'returns the station installed least recently' do
        create_list(:station, 12)
        station = create(:station, installation_date: '1920-01-30')

        expect(Station.oldest_station).to eq(station)
      end
    end
  end
end
