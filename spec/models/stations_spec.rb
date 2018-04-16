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
    describe '#total_stations' do
      it 'returns the count of stations' do
        create_list(:station, 12)
        stations = Station.all

        expect(stations.total_stations).to eq(12)
      end
    end
    describe '#average_bikes' do
      it 'returns the average bikes per station' do
        create_list(:station, 12)
        stations = Station.all

        expect(stations.average_bikes).to eq(Station.average(:dock_count))
      end
    end
    describe '#most_bikes' do
      it 'returns the most bikes at any station' do
        create_list(:station, 12)
        stations = Station.all

        expect(stations.most_bikes).to eq(Station.maximum(:dock_count))
      end
    end
  end
end
