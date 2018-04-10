require 'rails_helper'

describe Condition do
  context 'validations' do
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
          max_wind_speed_mph: 7,
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
        condition = Condition.create!(
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
          max_wind_speed_mph: 7,
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
end
