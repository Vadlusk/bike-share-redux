require 'rails_helper'

describe Condition do
  describe 'validations' do
    context 'valid attributes' do
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

    context 'invalid attributes' do
      it 'is invalid without a date' do
        condition = Condition.create(
          date: '',
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

        expect(condition).to_not be_valid
      end
    end
  end

  describe 'class methods' do
    it '.trips_by_temperature' do
      date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
      date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
      date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
      create(:condition, date: date_1, max_temperature_f: 75)
      create(:condition, date: date_2, max_temperature_f: 78)
      create(:condition, date: date_3, max_temperature_f: 78)
      create_list(:trip, 3, start_date: date_1)
      create_list(:trip, 5, start_date: date_2)
      create_list(:trip, 2, start_date: date_3)

      actual = Condition.trips_by_temperature([70..80])
      expected =  {date_1=>3, date_2=>5, date_3=>2}

      expect(expected).to eq(actual)
    end


    it '.return_min' do
      date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
      date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
      date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')

      actual = Condition.return_min({date_1=>3, date_2=>5, date_3=>2})
      expected = [date_3, 2]

      expect(actual).to eq(expected)
    end

    it '.return_max' do
      date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
      date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
      date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')

      actual = Condition.return_max({date_1=>3, date_2=>5, date_3=>2})
      expected = [date_2, 5]

      expect(actual).to eq(expected)
    end

    it '.return_average' do
      date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
      date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
      date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')

      actual = Condition.return_avg({date_1=>3, date_2=>5, date_3=>7})
      expected = 5

      expect(actual).to eq(expected)
    end

    it '.max_trips_by_temperature' do
      date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
      date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
      date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
      create(:condition, date: date_1, max_temperature_f: 75)
      create(:condition, date: date_2, max_temperature_f: 78)
      create(:condition, date: date_3, max_temperature_f: 78)
      create_list(:trip, 3, start_date: date_1)
      create_list(:trip, 5, start_date: date_2)
      create_list(:trip, 2, start_date: date_3)

      actual = Condition.max_trips_by_temperature
      expected = {"40°F to 49°F"=>[nil, 0],
                  "50°F to 59°F"=>[nil, 0],
                  "60°F to 69°F"=>[nil, 0],
                  "70°F to 79°F"=>[date_2, 5],
                  "80°F to 89°F"=>[nil, 0],
                  "90°F to 99°F"=>[nil, 0],
                  "100°F to 110°F"=>[nil, 0]
                }

      expect(actual).to eq(expected)
    end

    it '.min_trips_by_temperature' do
      date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
      date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
      date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
      create(:condition, date: date_1, max_temperature_f: 75)
      create(:condition, date: date_2, max_temperature_f: 78)
      create(:condition, date: date_3, max_temperature_f: 78)
      create_list(:trip, 3, start_date: date_1)
      create_list(:trip, 5, start_date: date_2)
      create_list(:trip, 2, start_date: date_3)

      actual = Condition.min_trips_by_temperature
      expected = {"40°F to 49°F"=>[nil, 0],
                  "50°F to 59°F"=>[nil, 0],
                  "60°F to 69°F"=>[nil, 0],
                  "70°F to 79°F"=>[date_3, 2],
                  "80°F to 89°F"=>[nil, 0],
                  "90°F to 99°F"=>[nil, 0],
                  "100°F to 110°F"=>[nil, 0]
                }

      expect(actual).to eq(expected)
    end

    it '.avg_trips_by_temperature' do
      date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
      date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
      date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
      create(:condition, date: date_1, max_temperature_f: 75)
      create(:condition, date: date_2, max_temperature_f: 78)
      create(:condition, date: date_3, max_temperature_f: 78)
      create_list(:trip, 3, start_date: date_1)
      create_list(:trip, 5, start_date: date_2)
      create_list(:trip, 7, start_date: date_3)

      actual = Condition.avg_trips_by_temperature
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
  end
end


# skip '.trips_by_temperature_breakdown' do
#   date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
#   date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
#   date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
#   create(:condition, date: date_1, max_temperature_f: 75)
#   create(:condition, date: date_2, max_temperature_f: 78)
#   create(:condition, date: date_3, max_temperature_f: 78)
#   create_list(:trip, 3, start_date: date_1)
#   create_list(:trip, 5, start_date: date_2)
#   create_list(:trip, 2, start_date: date_3)
#
#   actual = Condition.trips_by_temperature_breakdown
#   expected = {"40°F to 49°F"=>{},
#               "50°F to 59°F"=>{},
#               "60°F to 69°F"=>{},
#               "70°F to 79°F"=>{date_1=>3, date_2=>5, date_3=>2},
#               "80°F to 89°F"=>{},
#               "90°F to 99°F"=>{},
#               "100°F to 110°F"=>{}
#             }
#
#   expect(actual).to eq(expected)
# end
