require 'rails_helper'

describe 'User' do
  context 'as an admin' do
    describe 'visits the conditions dashboards' do
      it 'and sees rides by temperature' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, max_temperature_f: 75, precipitation_inches: 1.49, mean_wind_speed_mph: 30, mean_visibility_miles: 24)
        create(:condition, date: date_2, max_temperature_f: 78, precipitation_inches: 1.00, mean_wind_speed_mph: 32, mean_visibility_miles: 23)
        create(:condition, date: date_3, max_temperature_f: 78, precipitation_inches: 1.25, mean_wind_speed_mph: 39, mean_visibility_miles: 21)
        create_list(:trip, 3, start_date: date_1)
        create_list(:trip, 5, start_date: date_2)
        create_list(:trip, 2, start_date: date_3)

        admin = create(:admin)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit admin_conditions_dashboard_path

        within(".highest_rides_by_temperature") do
          expect(page).to have_content("Highest Number of Rides by Temperature")
          expect(page).to have_content("40°F to 49°F: 0")
          expect(page).to have_content("50°F to 59°F: 0")
          expect(page).to have_content("60°F to 69°F: 0")
          expect(page).to have_content("70°F to 79°F: 5")
          expect(page).to have_content("80°F to 89°F: 0")
          expect(page).to have_content("90°F to 99°F: 0")
        end

        within(".lowest_rides_by_temperature") do
          expect(page).to have_content("Lowest Number of Rides by Temperature")
          expect(page).to have_content("40°F to 49°F: 0")
          expect(page).to have_content("50°F to 59°F: 0")
          expect(page).to have_content("60°F to 69°F: 0")
          expect(page).to have_content("70°F to 79°F: 2")
          expect(page).to have_content("80°F to 89°F: 0")
          expect(page).to have_content("90°F to 99°F: 0")
        end

        within(".average_rides_by_temperature") do
          expect(page).to have_content("Average Number of Rides by Temperature")
          expect(page).to have_content("40°F to 49°F: 0")
          expect(page).to have_content("50°F to 59°F: 0")
          expect(page).to have_content("60°F to 69°F: 0")
          expect(page).to have_content("70°F to 79°F: 3.33")
          expect(page).to have_content("80°F to 89°F: 0")
          expect(page).to have_content("90°F to 99°F: 0")
        end
      end

      it 'and sees rides by precipitation' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, max_temperature_f: 75, precipitation_inches: 1.49, mean_wind_speed_mph: 30, mean_visibility_miles: 24)
        create(:condition, date: date_2, max_temperature_f: 78, precipitation_inches: 1.00, mean_wind_speed_mph: 32, mean_visibility_miles: 23)
        create(:condition, date: date_3, max_temperature_f: 78, precipitation_inches: 1.25, mean_wind_speed_mph: 39, mean_visibility_miles: 21)
        create_list(:trip, 15, start_date: date_1)
        create_list(:trip, 10, start_date: date_2)
        create_list(:trip, 5, start_date: date_3)

        admin = create(:admin)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit admin_conditions_dashboard_path

        within(".highest_rides_by_precipitation") do
          expect(page).to have_content("Highest Number of Rides by Precipitation")
          expect(page).to have_content("0.00\" to 0.49\": 0")
          expect(page).to have_content("0.50\" to 0.99\": 0")
          expect(page).to have_content("1.00\" to 1.49\": 15")
          expect(page).to have_content("1.50\" to 1.99\": 0")
          expect(page).to have_content("2.00\" to 2.49\": 0")
          expect(page).to have_content("2.50\" to 2.99\": 0")
          expect(page).to have_content("3.00\" to 3.49\": 0")
        end

        within(".lowest_rides_by_precipitation") do
          expect(page).to have_content("Lowest Number of Rides by Precipitation")
          expect(page).to have_content("0.00\" to 0.49\": 0")
          expect(page).to have_content("0.50\" to 0.99\": 0")
          expect(page).to have_content("1.00\" to 1.49\": 5")
          expect(page).to have_content("1.50\" to 1.99\": 0")
          expect(page).to have_content("2.00\" to 2.49\": 0")
          expect(page).to have_content("2.50\" to 2.99\": 0")
          expect(page).to have_content("3.00\" to 3.49\": 0")
        end

        within(".average_rides_by_precipitation") do
          expect(page).to have_content("Average Number of Rides by Precipitation")
          expect(page).to have_content("0.00\" to 0.49\": 0")
          expect(page).to have_content("0.50\" to 0.99\": 0")
          expect(page).to have_content("1.00\" to 1.49\": 10")
          expect(page).to have_content("1.50\" to 1.99\": 0")
          expect(page).to have_content("2.00\" to 2.49\": 0")
          expect(page).to have_content("2.50\" to 2.99\": 0")
          expect(page).to have_content("3.00\" to 3.49\": 0")
        end
      end

      it 'and sees rides by wind speed' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, max_temperature_f: 75, precipitation_inches: 1.49, mean_wind_speed_mph: 30, mean_visibility_miles: 24)
        create(:condition, date: date_2, max_temperature_f: 78, precipitation_inches: 1.00, mean_wind_speed_mph: 32, mean_visibility_miles: 23)
        create(:condition, date: date_3, max_temperature_f: 78, precipitation_inches: 1.25, mean_wind_speed_mph: 39, mean_visibility_miles: 21)
        create_list(:trip, 18, start_date: date_1)
        create_list(:trip, 22, start_date: date_2)
        create_list(:trip, 15, start_date: date_3)

        admin = create(:admin)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit admin_conditions_dashboard_path

        within(".highest_rides_by_wind_speed") do
          expect(page).to have_content("Highest Number of Rides by Wind Speed")
          expect(page).to have_content("0 mph to 4 mph: 0")
          expect(page).to have_content("5 mph to 9 mph: 0")
          expect(page).to have_content("10 mph to 14 mph: 0")
          expect(page).to have_content("15 mph to 19 mph: 0")
          expect(page).to have_content("20 mph to 24 mph: 0")
          expect(page).to have_content("25 mph to 29 mph: 0")
          expect(page).to have_content("30 mph to 34 mph: 22")
          expect(page).to have_content("35 mph to 39 mph: 15")
          expect(page).to have_content("40 mph to 44 mph: 0")
          expect(page).to have_content("45 mph to 49 mph: 0")
        end

        within(".lowest_rides_by_wind_speed") do
          expect(page).to have_content("Lowest Number of Rides by Wind Speed")
          expect(page).to have_content("0 mph to 4 mph: 0")
          expect(page).to have_content("5 mph to 9 mph: 0")
          expect(page).to have_content("10 mph to 14 mph: 0")
          expect(page).to have_content("15 mph to 19 mph: 0")
          expect(page).to have_content("20 mph to 24 mph: 0")
          expect(page).to have_content("25 mph to 29 mph: 0")
          expect(page).to have_content("30 mph to 34 mph: 18")
          expect(page).to have_content("35 mph to 39 mph: 15")
          expect(page).to have_content("40 mph to 44 mph: 0")
          expect(page).to have_content("45 mph to 49 mph: 0")
        end

        within(".average_rides_by_wind_speed") do
          expect(page).to have_content("Average Number of Rides by Wind Speed")
          expect(page).to have_content("0 mph to 4 mph: 0")
          expect(page).to have_content("5 mph to 9 mph: 0")
          expect(page).to have_content("10 mph to 14 mph: 0")
          expect(page).to have_content("15 mph to 19 mph: 0")
          expect(page).to have_content("20 mph to 24 mph: 0")
          expect(page).to have_content("25 mph to 29 mph: 0")
          expect(page).to have_content("30 mph to 34 mph: 20")
          expect(page).to have_content("35 mph to 39 mph: 15")
          expect(page).to have_content("40 mph to 44 mph: 0")
          expect(page).to have_content("45 mph to 49 mph: 0")
        end
      end

      it 'and sees rides by visibility' do
        date_1 = Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
        date_2 = Date.strptime('8/30/2013 9:08', '%m/%d/%Y %k:%M')
        date_3 = Date.strptime('8/31/2013 9:08', '%m/%d/%Y %k:%M')
        create(:condition, date: date_1, max_temperature_f: 75, precipitation_inches: 1.49, mean_wind_speed_mph: 30, mean_visibility_miles: 24)
        create(:condition, date: date_2, max_temperature_f: 78, precipitation_inches: 1.00, mean_wind_speed_mph: 32, mean_visibility_miles: 23)
        create(:condition, date: date_3, max_temperature_f: 78, precipitation_inches: 1.25, mean_wind_speed_mph: 39, mean_visibility_miles: 21)
        create_list(:trip, 12, start_date: date_1)
        create_list(:trip, 23, start_date: date_2)
        create_list(:trip, 10, start_date: date_3)

        admin = create(:admin)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit admin_conditions_dashboard_path

        within(".highest_rides_by_visibility") do
          expect(page).to have_content("Highest Number of Rides by Visibility")
          expect(page).to have_content("0 miles to 4 miles: 0")
          expect(page).to have_content("5 miles to 9 miles: 0")
          expect(page).to have_content("10 miles to 14 miles: 0")
          expect(page).to have_content("15 miles to 19 miles: 0")
          expect(page).to have_content("20 miles to 24 miles: 23")
          expect(page).to have_content("25 miles to 29 miles: 0")
        end

        within(".lowest_rides_by_visibility") do
          expect(page).to have_content("Lowest Number of Rides by Visibility")
          expect(page).to have_content("0 miles to 4 miles: 0")
          expect(page).to have_content("5 miles to 9 miles: 0")
          expect(page).to have_content("10 miles to 14 miles: 0")
          expect(page).to have_content("15 miles to 19 miles: 0")
          expect(page).to have_content("20 miles to 24 miles: 10")
          expect(page).to have_content("25 miles to 29 miles: 0")
        end

        within(".average_rides_by_visibility") do
          expect(page).to have_content("Average Number of Rides by Visibility")
          expect(page).to have_content("0 miles to 4 miles: 0")
          expect(page).to have_content("5 miles to 9 miles: 0")
          expect(page).to have_content("10 miles to 14 miles: 0")
          expect(page).to have_content("15 miles to 19 miles: 0")
          expect(page).to have_content("20 miles to 24 miles: 15")
          expect(page).to have_content("25 miles to 29 miles: 0")
        end
      end
    end
  end
end
