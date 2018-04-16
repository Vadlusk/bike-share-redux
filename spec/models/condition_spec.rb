require 'rails_helper'

describe Condition do
  describe 'validations' do
    it {should validate_presence_of(:date)}
    it 'is valid with all attributes' do
      condition = Condition.create!(
        date: '10/12/2013',
        max_temperature_f: 60,
        mean_temperature_f: 50,
        min_temperature_f: 40,
        max_dew_point_f: 40,
        mean_dew_point_f: 40,
        min_dew_point_f: 30,
        max_humidity: 75,
        mean_humidity: 50,
        min_humidity: 10,
        max_sea_level_pressure_inches: 29.95,
        mean_sea_level_pressure_inches: 30.00,
        min_sea_level_pressure_inches: 29.80,
        max_visibility_miles: 10,
        mean_visibility_miles: 5,
        min_visibility_miles: 0,
        max_wind_Speed_mph: 7,
        mean_wind_speed_mph: 1,
        max_gust_speed_mph: 6,
        precipitation_inches: 0,
        cloud_cover: 4,
        events: 'rain',
        wind_dir_degrees: 180,
        zip_code: 80210
      )

      expect(condition).to be_valid
    end
  end

  describe 'class methods' do
    describe '.min_trips_by' do
      it 'can calculate minimum trips by temperature' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        date_4 = Date.strptime('9/01/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, max_temperature_f: 75)
        create(:condition, date: date_2, max_temperature_f: 78)
        create(:condition, date: date_3, max_temperature_f: 78)
        create(:condition, date: date_4, max_temperature_f: 1)
        create_list(:trip, 3, start_date: date_1)
        create_list(:trip, 5, start_date: date_2)
        create_list(:trip, 2, start_date: date_3)
        create_list(:trip, 1, start_date: date_4)

        actual = Condition.min_trips_by(max_temperature_f: [70..80])

        expect(actual.trip_count).to eq(2)
      end

      it 'can calculate minimum trips by precipitation' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        date_4 = Date.strptime('9/1/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, precipitation_inches: 1.49)
        create(:condition, date: date_2, precipitation_inches: 1.00)
        create(:condition, date: date_3, precipitation_inches: 1.25)
        create(:condition, date: date_4, precipitation_inches: 0.5)
        create_list(:trip, 3, start_date: date_1)
        create_list(:trip, 6, start_date: date_2)
        create_list(:trip, 1, start_date: date_3)
        create_list(:trip, 0, start_date: date_4)


        actual = Condition.min_trips_by(precipitation_inches: [1.00..1.49])

        expect(actual.trip_count).to eq(1)
      end

      it 'can calculate minimum trips by wind speed' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        date_4 = Date.strptime('9/01/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, mean_wind_speed_mph: 5)
        create(:condition, date: date_2, mean_wind_speed_mph: 7)
        create(:condition, date: date_3, mean_wind_speed_mph: 9)
        create(:condition, date: date_3, mean_wind_speed_mph: 10)
        create_list(:trip, 5, start_date: date_1)
        create_list(:trip, 2, start_date: date_2)
        create_list(:trip, 3, start_date: date_3)
        create_list(:trip, 1, start_date: date_4)

        actual = Condition.min_trips_by(mean_wind_speed_mph: [5..9])

        expect(actual.trip_count).to eq(2)
      end

      it 'can calculate min trips by visibility' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        date_4 = Date.strptime('9/01/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, mean_visibility_miles: 24)
        create(:condition, date: date_2, mean_visibility_miles: 23)
        create(:condition, date: date_3, mean_visibility_miles: 21)
        create(:condition, date: date_4, mean_visibility_miles: 19)
        create_list(:trip, 10, start_date: date_1)
        create_list(:trip, 20, start_date: date_2)
        create_list(:trip, 23, start_date: date_3)
        create_list(:trip, 9, start_date: date_4)

        actual = Condition.min_trips_by(mean_visibility_miles: [20..24])

        expect(actual.trip_count).to eq(10)
      end
    end

    describe '.max_trips_by' do
      it 'can calculate maximum trips by temperature' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        date_4 = Date.strptime('9/01/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, max_temperature_f: 75)
        create(:condition, date: date_2, max_temperature_f: 78)
        create(:condition, date: date_3, max_temperature_f: 78)
        create(:condition, date: date_4, max_temperature_f: 1)
        create_list(:trip, 3, start_date: date_1)
        create_list(:trip, 5, start_date: date_2)
        create_list(:trip, 2, start_date: date_3)
        create_list(:trip, 7, start_date: date_4)

        actual = Condition.max_trips_by(max_temperature_f: [70..80])

        expect(actual.trip_count).to eq(5)
      end

      it 'can calculate maximum trips by precipitation' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        date_4 = Date.strptime('9/1/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, precipitation_inches: 1.49)
        create(:condition, date: date_2, precipitation_inches: 1.00)
        create(:condition, date: date_3, precipitation_inches: 1.25)
        create(:condition, date: date_4, precipitation_inches: 0.5)
        create_list(:trip, 3, start_date: date_1)
        create_list(:trip, 6, start_date: date_2)
        create_list(:trip, 1, start_date: date_3)
        create_list(:trip, 8, start_date: date_4)


        actual = Condition.max_trips_by(precipitation_inches: [1.00..1.49])

        expect(actual.trip_count).to eq(6)
      end

      it 'can calculate maximum trips by wind speed' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        date_4 = Date.strptime('9/01/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, mean_wind_speed_mph: 5)
        create(:condition, date: date_2, mean_wind_speed_mph: 7)
        create(:condition, date: date_3, mean_wind_speed_mph: 9)
        create(:condition, date: date_3, mean_wind_speed_mph: 10)
        create_list(:trip, 5, start_date: date_1)
        create_list(:trip, 2, start_date: date_2)
        create_list(:trip, 3, start_date: date_3)
        create_list(:trip, 8, start_date: date_4)

        actual = Condition.max_trips_by(mean_wind_speed_mph: [5..9])

        expect(actual.trip_count).to eq(5)
      end

      it 'can calculate max trips by visibility' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        date_4 = Date.strptime('9/01/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, mean_visibility_miles: 24)
        create(:condition, date: date_2, mean_visibility_miles: 23)
        create(:condition, date: date_3, mean_visibility_miles: 21)
        create(:condition, date: date_4, mean_visibility_miles: 19)
        create_list(:trip, 10, start_date: date_1)
        create_list(:trip, 20, start_date: date_2)
        create_list(:trip, 23, start_date: date_3)
        create_list(:trip, 25, start_date: date_4)

        actual = Condition.max_trips_by(mean_visibility_miles: [20..24])

        expect(actual.trip_count).to eq(23)
      end
    end

    describe '.trip_count_by' do
      it 'can calculate trips grouped by date by temperature' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        date_4 = Date.strptime('9/01/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, max_temperature_f: 75)
        create(:condition, date: date_2, max_temperature_f: 78)
        create(:condition, date: date_3, max_temperature_f: 78)
        create(:condition, date: date_4, max_temperature_f: 1)
        create_list(:trip, 3, start_date: date_1)
        create_list(:trip, 5, start_date: date_2)
        create_list(:trip, 2, start_date: date_3)
        create_list(:trip, 7, start_date: date_4)

        actual = Condition.trip_count_by(max_temperature_f: [70..80])
        expected = {date_1 => 3, date_2 => 5, date_3 => 2}

        expect(actual).to eq(expected)
      end

      it 'can calculate trips grouped by date by precipitation' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        date_4 = Date.strptime('9/1/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, precipitation_inches: 1.49)
        create(:condition, date: date_2, precipitation_inches: 1.00)
        create(:condition, date: date_3, precipitation_inches: 1.25)
        create(:condition, date: date_4, precipitation_inches: 0.5)
        create_list(:trip, 3, start_date: date_1)
        create_list(:trip, 6, start_date: date_2)
        create_list(:trip, 1, start_date: date_3)
        create_list(:trip, 8, start_date: date_4)


        actual = Condition.trip_count_by(precipitation_inches: [1.00..1.49])
        expected = {date_1 => 3, date_2 => 6, date_3 => 1}

        expect(actual).to eq(expected)
      end

      it 'can calculate trips date by wind speed' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        date_4 = Date.strptime('9/01/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, mean_wind_speed_mph: 5)
        create(:condition, date: date_2, mean_wind_speed_mph: 7)
        create(:condition, date: date_3, mean_wind_speed_mph: 9)
        create(:condition, date: date_3, mean_wind_speed_mph: 10)
        create_list(:trip, 5, start_date: date_1)
        create_list(:trip, 2, start_date: date_2)
        create_list(:trip, 3, start_date: date_3)
        create_list(:trip, 8, start_date: date_4)

        actual = Condition.trip_count_by(mean_wind_speed_mph: [5..9])
        expected = {date_1 => 5, date_2 => 2, date_3 => 3}

        expect(actual).to eq(expected)
      end

      it 'can calculate trips by date by visibility' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        date_4 = Date.strptime('9/01/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, mean_visibility_miles: 24)
        create(:condition, date: date_2, mean_visibility_miles: 23)
        create(:condition, date: date_3, mean_visibility_miles: 21)
        create(:condition, date: date_4, mean_visibility_miles: 19)
        create_list(:trip, 10, start_date: date_1)
        create_list(:trip, 20, start_date: date_2)
        create_list(:trip, 23, start_date: date_3)
        create_list(:trip, 25, start_date: date_4)

        actual = Condition.trip_count_by(mean_visibility_miles: [20..24])
        expected = {date_1 => 10, date_2 => 20, date_3 => 23}
        expect(actual).to eq(expected)
      end
    end

    it '.return_average' do
      date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
      date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
      date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')

      actual = Condition.return_avg({date_1=>3, date_2=>5, date_3=>7})
      expected = 5

      expect(actual).to eq(expected)
    end

    describe '.build_trips_hash' do
      it 'can return hash of max trips over temperature ranges' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, max_temperature_f: 75)
        create(:condition, date: date_2, max_temperature_f: 78)
        create(:condition, date: date_3, max_temperature_f: 78)
        create_list(:trip, 3, start_date: date_1)
        create_list(:trip, 5, start_date: date_2)
        create_list(:trip, 2, start_date: date_3)

        actual = Condition.build_trips_hash(Condition.temperature_ranges, :max_trips_by, :max_temperature_f)
        expected = {"40°F to 49°F"=>0,
                    "50°F to 59°F"=>0,
                    "60°F to 69°F"=>0,
                    "70°F to 79°F"=>5,
                    "80°F to 89°F"=>0,
                    "90°F to 99°F"=>0,
                    "100°F to 110°F"=>0}

        expect(actual).to eq(expected)
      end

      it 'can return hash of min trips over temperature ranges' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, max_temperature_f: 75)
        create(:condition, date: date_2, max_temperature_f: 78)
        create(:condition, date: date_3, max_temperature_f: 78)
        create_list(:trip, 3, start_date: date_1)
        create_list(:trip, 5, start_date: date_2)
        create_list(:trip, 2, start_date: date_3)

        actual = Condition.build_trips_hash(Condition.temperature_ranges, :min_trips_by, :max_temperature_f)
        expected = {"40°F to 49°F"=>0,
                    "50°F to 59°F"=>0,
                    "60°F to 69°F"=>0,
                    "70°F to 79°F"=>2,
                    "80°F to 89°F"=>0,
                    "90°F to 99°F"=>0,
                    "100°F to 110°F"=>0}

        expect(actual).to eq(expected)
      end

      it 'can return a hash of max trips over precipitation ranges' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, precipitation_inches: 1.49)
        create(:condition, date: date_2, precipitation_inches: 1.00)
        create(:condition, date: date_3, precipitation_inches: 1.25)
        create_list(:trip, 6, start_date: date_1)
        create_list(:trip, 3, start_date: date_2)
        create_list(:trip, 1, start_date: date_3)

        actual = Condition.build_trips_hash(Condition.precipitation_ranges, :max_trips_by, :precipitation_inches)
        expected = {"0.00\" to 0.49\""=>0,
                    "0.50\" to 0.99\""=>0,
                    "1.00\" to 1.49\""=>6,
                    "1.50\" to 1.99\""=>0,
                    "2.00\" to 2.49\""=>0,
                    "2.50\" to 2.99\""=>0,
                    "3.00\" to 3.49\""=>0}

        expect(actual).to eq(expected)
      end

      it 'can return a hash of min trips over precipitation ranges' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, precipitation_inches: 1.49)
        create(:condition, date: date_2, precipitation_inches: 1.00)
        create(:condition, date: date_3, precipitation_inches: 1.25)
        create_list(:trip, 6, start_date: date_1)
        create_list(:trip, 3, start_date: date_2)
        create_list(:trip, 1, start_date: date_3)

        actual = Condition.build_trips_hash(Condition.precipitation_ranges, :min_trips_by, :precipitation_inches)
        expected = {"0.00\" to 0.49\""=>0,
                    "0.50\" to 0.99\""=>0,
                    "1.00\" to 1.49\""=>1,
                    "1.50\" to 1.99\""=>0,
                    "2.00\" to 2.49\""=>0,
                    "2.50\" to 2.99\""=>0,
                    "3.00\" to 3.49\""=>0}

        expect(actual).to eq(expected)
      end

      it 'can return a hash of max trips over wind speed ranges' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, mean_wind_speed_mph: 30)
        create(:condition, date: date_2, mean_wind_speed_mph: 32)
        create(:condition, date: date_3, mean_wind_speed_mph: 39)
        create_list(:trip, 5, start_date: date_1)
        create_list(:trip, 2, start_date: date_2)
        create_list(:trip, 10, start_date: date_3)

        actual = Condition.build_trips_hash(Condition.wind_ranges, :max_trips_by, :mean_wind_speed_mph)
        expected =    {"0 mph to 4 mph"=>0,
                       "5 mph to 9 mph"=>0,
                       "10 mph to 14 mph"=>0,
                       "15 mph to 19 mph"=>0,
                       "20 mph to 24 mph"=>0,
                       "25 mph to 29 mph"=>0,
                       "30 mph to 34 mph"=>5,
                       "35 mph to 39 mph"=>10,
                       "40 mph to 44 mph"=>0,
                       "45 mph to 49 mph"=>0}

        expect(actual).to eq(expected)
      end

      it 'can return a hash of min trips over wind speed ranges' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, mean_wind_speed_mph: 30)
        create(:condition, date: date_2, mean_wind_speed_mph: 32)
        create(:condition, date: date_3, mean_wind_speed_mph: 39)
        create_list(:trip, 5, start_date: date_1)
        create_list(:trip, 2, start_date: date_2)
        create_list(:trip, 10, start_date: date_3)

        actual = Condition.build_trips_hash(Condition.wind_ranges, :min_trips_by, :mean_wind_speed_mph)
        expected =    {"0 mph to 4 mph"=>0,
                       "5 mph to 9 mph"=>0,
                       "10 mph to 14 mph"=>0,
                       "15 mph to 19 mph"=>0,
                       "20 mph to 24 mph"=>0,
                       "25 mph to 29 mph"=>0,
                       "30 mph to 34 mph"=>2,
                       "35 mph to 39 mph"=>10,
                       "40 mph to 44 mph"=>0,
                       "45 mph to 49 mph"=>0}

        expect(actual).to eq(expected)
      end

      it 'can return hash of max trips over visibility ranges' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, mean_visibility_miles: 24)
        create(:condition, date: date_2, mean_visibility_miles: 23)
        create(:condition, date: date_3, mean_visibility_miles: 21)
        create_list(:trip, 10, start_date: date_1)
        create_list(:trip, 23, start_date: date_2)
        create_list(:trip, 20, start_date: date_3)

        actual = Condition.build_trips_hash(Condition.visibility_ranges, :max_trips_by, :mean_visibility_miles)
        expected = {"0 miles to 4 miles"=>0,
                    "5 miles to 9 miles"=>0,
                    "10 miles to 14 miles"=>0,
                    "15 miles to 19 miles"=>0,
                    "20 miles to 24 miles"=>23,
                    "25 miles to 29 miles"=>0}

        expect(actual).to eq(expected)
      end

      it 'can return hash of min trips over visibility ranges' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, mean_visibility_miles: 24)
        create(:condition, date: date_2, mean_visibility_miles: 23)
        create(:condition, date: date_3, mean_visibility_miles: 21)
        create_list(:trip, 10, start_date: date_1)
        create_list(:trip, 23, start_date: date_2)
        create_list(:trip, 20, start_date: date_3)

        actual = Condition.build_trips_hash(Condition.visibility_ranges, :min_trips_by, :mean_visibility_miles)
        expected = {"0 miles to 4 miles"=>0,
                    "5 miles to 9 miles"=>0,
                    "10 miles to 14 miles"=>0,
                    "15 miles to 19 miles"=>0,
                    "20 miles to 24 miles"=>10,
                    "25 miles to 29 miles"=>0}

        expect(actual).to eq(expected)
      end
    end

    describe '.build_average_trips_hash' do
      it 'can return hash of avg trips over temperature ranges' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, max_temperature_f: 75)
        create(:condition, date: date_2, max_temperature_f: 78)
        create(:condition, date: date_3, max_temperature_f: 78)
        create_list(:trip, 3, start_date: date_1)
        create_list(:trip, 5, start_date: date_2)
        create_list(:trip, 7, start_date: date_3)

        actual = Condition.build_avg_trips_hash(Condition.temperature_ranges, :trip_count_by, :max_temperature_f)
        expected = {"40°F to 49°F"=>0,
                    "50°F to 59°F"=>0,
                    "60°F to 69°F"=>0,
                    "70°F to 79°F"=>5,
                    "80°F to 89°F"=>0,
                    "90°F to 99°F"=>0,
                    "100°F to 110°F"=>0
                  }

        expect(actual).to eq(expected)
      end

      it 'can return hash of avg trips by precipitation ranges' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, precipitation_inches: 1.49)
        create(:condition, date: date_2, precipitation_inches: 1.00)
        create(:condition, date: date_3, precipitation_inches: 1.25)
        create_list(:trip, 1, start_date: date_1)
        create_list(:trip, 3, start_date: date_2)
        create_list(:trip, 6, start_date: date_3)

        actual = Condition.build_avg_trips_hash(Condition.precipitation_ranges, :trip_count_by, :precipitation_inches)
        expected = {"0.00\" to 0.49\""=>0,
                    "0.50\" to 0.99\""=>0,
                    "1.00\" to 1.49\""=>3.33,
                    "1.50\" to 1.99\""=>0,
                    "2.00\" to 2.49\""=>0,
                    "2.50\" to 2.99\""=>0,
                    "3.00\" to 3.49\""=>0}

        expect(actual).to eq(expected)
      end

      it 'can return avg trips by wind speed' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, mean_wind_speed_mph: 30)
        create(:condition, date: date_2, mean_wind_speed_mph: 32)
        create(:condition, date: date_3, mean_wind_speed_mph: 39)
        create_list(:trip, 25, start_date: date_1)
        create_list(:trip, 15, start_date: date_2)
        create_list(:trip, 5, start_date: date_3)

        actual = Condition.build_avg_trips_hash(Condition.wind_ranges, :trip_count_by, :mean_wind_speed_mph)
        expected = {"0 mph to 4 mph"=>0,
                    "5 mph to 9 mph"=>0,
                    "10 mph to 14 mph"=>0,
                    "15 mph to 19 mph"=>0,
                    "20 mph to 24 mph"=>0,
                    "25 mph to 29 mph"=>0,
                    "30 mph to 34 mph"=>20,
                    "35 mph to 39 mph"=>5,
                    "40 mph to 44 mph"=>0,
                    "45 mph to 49 mph"=>0}

        expect(actual).to eq(expected)
      end

      it 'can return hash of avg trips by visibility ranges' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, mean_visibility_miles: 24)
        create(:condition, date: date_2, mean_visibility_miles: 23)
        create(:condition, date: date_3, mean_visibility_miles: 21)
        create_list(:trip, 12, start_date: date_1)
        create_list(:trip, 23, start_date: date_2)
        create_list(:trip, 10, start_date: date_3)

        actual = Condition.build_avg_trips_hash(Condition.visibility_ranges, :trip_count_by, :mean_visibility_miles)
        expected = {"0 miles to 4 miles"=>0,
                    "5 miles to 9 miles"=>0,
                    "10 miles to 14 miles"=>0,
                    "15 miles to 19 miles"=>0,
                    "20 miles to 24 miles"=>15,
                    "25 miles to 29 miles"=>0}

        expect(actual).to eq(expected)
      end
    end
  end
end



#
#       skip 'can return max trips by precipitation' do
#         date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
#         date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
#         date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
#         create(:condition, date: date_1, precipitation_inches: 1.49)
#         create(:condition, date: date_2, precipitation_inches: 1.00)
#         create(:condition, date: date_3, precipitation_inches: 1.25)
#         create_list(:trip, 6, start_date: date_1)
#         create_list(:trip, 3, start_date: date_2)
#         create_list(:trip, 1, start_date: date_3)
#
#         actual = Condition.max_trips_by(Condition.precipitation_ranges, :trips_by_precipitation)
#         expected = {"0.00\" to 0.49\""=>[nil, 0],
#                     "0.50\" to 0.99\""=>[nil, 0],
#                     "1.00\" to 1.49\""=>[date_1, 6],
#                     "1.50\" to 1.99\""=>[nil, 0],
#                     "2.00\" to 2.49\""=>[nil, 0],
#                     "2.50\" to 2.99\""=>[nil, 0],
#                     "3.00\" to 3.49\""=>[nil, 0]}
#
#         expect(actual).to eq(expected)
#       end
#
#       skip 'can return max trips by wind speed' do
#         date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
#         date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
#         date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
#         create(:condition, date: date_1, mean_wind_speed_mph: 30)
#         create(:condition, date: date_2, mean_wind_speed_mph: 32)
#         create(:condition, date: date_3, mean_wind_speed_mph: 39)
#         create_list(:trip, 5, start_date: date_1)
#         create_list(:trip, 2, start_date: date_2)
#         create_list(:trip, 10, start_date: date_3)
#
#         actual = Condition.max_trips_by(Condition.wind_ranges, :trips_by_wind_speed)
#         expected =    {"0 mph to 4 mph"=>[nil, 0],
#                        "5 mph to 9 mph"=>[nil, 0],
#                        "10 mph to 14 mph"=>[nil, 0],
#                        "15 mph to 19 mph"=>[nil, 0],
#                        "20 mph to 24 mph"=>[nil, 0],
#                        "25 mph to 29 mph"=>[nil, 0],
#                        "30 mph to 34 mph"=>[date_1, 5],
#                        "35 mph to 39 mph"=>[date_3, 10],
#                        "40 mph to 44 mph"=>[nil, 0],
#                        "45 mph to 49 mph"=>[nil, 0]}
#
#         expect(actual).to eq(expected)
#       end
#
#       skip 'can return max trips by visibility' do
#         date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
#         date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
#         date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
#         create(:condition, date: date_1, mean_visibility_miles: 24)
#         create(:condition, date: date_2, mean_visibility_miles: 23)
#         create(:condition, date: date_3, mean_visibility_miles: 21)
#         create_list(:trip, 10, start_date: date_1)
#         create_list(:trip, 23, start_date: date_2)
#         create_list(:trip, 20, start_date: date_3)
#
#         actual = Condition.max_trips_by(Condition.visibility_ranges, :trips_by_visibility)
#         expected = {"0 miles to 4 miles"=>[nil, 0],
#                     "5 miles to 9 miles"=>[nil, 0],
#                     "10 miles to 14 miles"=>[nil, 0],
#                     "15 miles to 19 miles"=>[nil, 0],
#                     "20 miles to 24 miles"=>[date_2, 23],
#                     "25 miles to 29 miles"=>[nil, 0]}
#
#         expect(actual).to eq(expected)
#       end
#     end
#
#     describe '.min_trips_by' do
#       skip 'can return min trips by temperature' do
#         date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
#         date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
#         date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
#         create(:condition, date: date_1, max_temperature_f: 75)
#         create(:condition, date: date_2, max_temperature_f: 78)
#         create(:condition, date: date_3, max_temperature_f: 78)
#         create_list(:trip, 3, start_date: date_1)
#         create_list(:trip, 5, start_date: date_2)
#         create_list(:trip, 2, start_date: date_3)
#
#         actual = Condition.min_trips_by(Condition.temperature_ranges, :trips_by_temperature)
#         expected = {"40°F to 49°F"=>[nil, 0],
#                     "50°F to 59°F"=>[nil, 0],
#                     "60°F to 69°F"=>[nil, 0],
#                     "70°F to 79°F"=>[date_3, 2],
#                     "80°F to 89°F"=>[nil, 0],
#                     "90°F to 99°F"=>[nil, 0],
#                     "100°F to 110°F"=>[nil, 0]
#                   }
#
#         expect(actual).to eq(expected)
#       end
#
#       skip 'can return min trips by precipitation' do
#         date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
#         date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
#         date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
#         create(:condition, date: date_1, precipitation_inches: 1.49)
#         create(:condition, date: date_2, precipitation_inches: 1.00)
#         create(:condition, date: date_3, precipitation_inches: 1.25)
#         create_list(:trip, 1, start_date: date_1)
#         create_list(:trip, 3, start_date: date_2)
#         create_list(:trip, 6, start_date: date_3)
#
#         actual = Condition.min_trips_by(Condition.precipitation_ranges, :trips_by_precipitation)
#         expected = {"0.00\" to 0.49\""=>[nil, 0],
#                     "0.50\" to 0.99\""=>[nil, 0],
#                     "1.00\" to 1.49\""=>[date_1, 1],
#                     "1.50\" to 1.99\""=>[nil, 0],
#                     "2.00\" to 2.49\""=>[nil, 0],
#                     "2.50\" to 2.99\""=>[nil, 0],
#                     "3.00\" to 3.49\""=>[nil, 0]}
#
#         expect(actual).to eq(expected)
#       end
#
#       skip 'can return min trips by wind speed' do
#         date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
#         date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
#         date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
#         create(:condition, date: date_1, mean_wind_speed_mph: 30)
#         create(:condition, date: date_2, mean_wind_speed_mph: 32)
#         create(:condition, date: date_3, mean_wind_speed_mph: 39)
#         create_list(:trip, 5, start_date: date_1)
#         create_list(:trip, 2, start_date: date_2)
#         create_list(:trip, 10, start_date: date_3)
#
#         actual = Condition.min_trips_by(Condition.wind_ranges, :trips_by_wind_speed)
#         expected = {"0 mph to 4 mph"=>[nil, 0],
#                     "5 mph to 9 mph"=>[nil, 0],
#                     "10 mph to 14 mph"=>[nil, 0],
#                     "15 mph to 19 mph"=>[nil, 0],
#                     "20 mph to 24 mph"=>[nil, 0],
#                     "25 mph to 29 mph"=>[nil, 0],
#                     "30 mph to 34 mph"=>[date_2, 2],
#                     "35 mph to 39 mph"=>[date_3, 10],
#                     "40 mph to 44 mph"=>[nil, 0],
#                     "45 mph to 49 mph"=>[nil, 0]}
#
#         expect(actual).to eq(expected)
#       end
#
#       skip 'can return min trips by visibility' do
#         date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
#         date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
#         date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
#         create(:condition, date: date_1, mean_visibility_miles: 24)
#         create(:condition, date: date_2, mean_visibility_miles: 23)
#         create(:condition, date: date_3, mean_visibility_miles: 21)
#         create_list(:trip, 12, start_date: date_1)
#         create_list(:trip, 23, start_date: date_2)
#         create_list(:trip, 10, start_date: date_3)
#
#         actual = Condition.min_trips_by(Condition.visibility_ranges, :trips_by_visibility)
#         expected = {"0 miles to 4 miles"=>[nil, 0],
#                     "5 miles to 9 miles"=>[nil, 0],
#                     "10 miles to 14 miles"=>[nil, 0],
#                     "15 miles to 19 miles"=>[nil, 0],
#                     "20 miles to 24 miles"=>[date_3, 10],
#                     "25 miles to 29 miles"=>[nil, 0]}
#
#         expect(actual).to eq(expected)
#       end
#     end
#
#     describe '.avg_trips_by' do
#       skip 'can return avg trips by temperature' do
#         date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
#         date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
#         date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
#         create(:condition, date: date_1, max_temperature_f: 75)
#         create(:condition, date: date_2, max_temperature_f: 78)
#         create(:condition, date: date_3, max_temperature_f: 78)
#         create_list(:trip, 3, start_date: date_1)
#         create_list(:trip, 5, start_date: date_2)
#         create_list(:trip, 7, start_date: date_3)
#
#         actual = Condition.avg_trips_by(Condition.temperature_ranges, :trips_by_temperature)
#         expected = {"40°F to 49°F"=>0,
#                     "50°F to 59°F"=>0,
#                     "60°F to 69°F"=>0,
#                     "70°F to 79°F"=>5,
#                     "80°F to 89°F"=>0,
#                     "90°F to 99°F"=>0,
#                     "100°F to 110°F"=>0
#                   }
#
#         expect(actual).to eq(expected)
#       end
#
#       skip 'can return avg trips by precipitation' do
#         date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
#         date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
#         date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
#         create(:condition, date: date_1, precipitation_inches: 1.49)
#         create(:condition, date: date_2, precipitation_inches: 1.00)
#         create(:condition, date: date_3, precipitation_inches: 1.25)
#         create_list(:trip, 1, start_date: date_1)
#         create_list(:trip, 3, start_date: date_2)
#         create_list(:trip, 6, start_date: date_3)
#
#         actual = Condition.avg_trips_by(Condition.precipitation_ranges, :trips_by_precipitation)
#         expected = {"0.00\" to 0.49\""=>0,
#                     "0.50\" to 0.99\""=>0,
#                     "1.00\" to 1.49\""=>3.33,
#                     "1.50\" to 1.99\""=>0,
#                     "2.00\" to 2.49\""=>0,
#                     "2.50\" to 2.99\""=>0,
#                     "3.00\" to 3.49\""=>0}
#
#         expect(actual).to eq(expected)
#       end
#
#       skip 'can return avg trips by wind speed' do
#         date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
#         date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
#         date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
#         create(:condition, date: date_1, mean_wind_speed_mph: 30)
#         create(:condition, date: date_2, mean_wind_speed_mph: 32)
#         create(:condition, date: date_3, mean_wind_speed_mph: 39)
#         create_list(:trip, 25, start_date: date_1)
#         create_list(:trip, 15, start_date: date_2)
#         create_list(:trip, 5, start_date: date_3)
#
#         actual = Condition.avg_trips_by(Condition.wind_ranges, :trips_by_wind_speed)
#         expected = {"0 mph to 4 mph"=>0,
#                     "5 mph to 9 mph"=>0,
#                     "10 mph to 14 mph"=>0,
#                     "15 mph to 19 mph"=>0,
#                     "20 mph to 24 mph"=>0,
#                     "25 mph to 29 mph"=>0,
#                     "30 mph to 34 mph"=>20,
#                     "35 mph to 39 mph"=>5,
#                     "40 mph to 44 mph"=>0,
#                     "45 mph to 49 mph"=>0}
#
#         expect(actual).to eq(expected)
#       end
#
#       skip 'can return avg trips by visibility' do
#         date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
#         date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
#         date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
#         create(:condition, date: date_1, mean_visibility_miles: 24)
#         create(:condition, date: date_2, mean_visibility_miles: 23)
#         create(:condition, date: date_3, mean_visibility_miles: 21)
#         create_list(:trip, 12, start_date: date_1)
#         create_list(:trip, 23, start_date: date_2)
#         create_list(:trip, 10, start_date: date_3)
#
#         actual = Condition.avg_trips_by(Condition.visibility_ranges, :trips_by_visibility)
#         expected = {"0 miles to 4 miles"=>0,
#                     "5 miles to 9 miles"=>0,
#                     "10 miles to 14 miles"=>0,
#                     "15 miles to 19 miles"=>0,
#                     "20 miles to 24 miles"=>15,
#                     "25 miles to 29 miles"=>0}
#
#         expect(actual).to eq(expected)
#       end
#     end
#   end
# end
