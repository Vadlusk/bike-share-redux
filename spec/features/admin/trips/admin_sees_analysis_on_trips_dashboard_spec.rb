require 'rails_helper'

describe 'Admin' do
  context 'visits the trips dashboard' do
    scenario 'and it has all analysis information' do
      stations = create_list(:station, 100)

      trip1 = Trip.create(duration: 1000, start_date: Date.strptime('1/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 100, subscription_type: 'Subscriber', zip_code: '94703')
      trip2 = Trip.create(duration: 90, start_date: Date.strptime('2/27/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 1, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 11, bike_id: 100, subscription_type: 'Subscriber', zip_code: '94703')
      trip3 = Trip.create(duration: 100, start_date: Date.strptime('3/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 9, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 10, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
      trip4 = Trip.create(duration: 300, start_date: Date.strptime('4/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 10, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 9, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
      trip5 = Trip.create(duration: 40, start_date: Date.strptime('5/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 90, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 8, bike_id: 100, subscription_type: 'Subscriber', zip_code: '94703')
      trip6 = Trip.create(duration: 4000, start_date: Date.strptime('6/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 30, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 7, bike_id: 17, subscription_type: 'Subscriber', zip_code: '94703')
      trip7 = Trip.create(duration: 7000, start_date: Date.strptime('7/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 40, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 6, bike_id: 17, subscription_type: 'Subscriber', zip_code: '94703')
      trip8 = Trip.create(duration: 9000, start_date: Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 50, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 5, bike_id: 180, subscription_type: 'Subscriber', zip_code: '94703')
      trip9 = Trip.create(duration: 10_000, start_date: Date.strptime('9/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 60, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 4, bike_id: 180, subscription_type: 'Customer', zip_code: '94703')
      trip10 = Trip.create(duration: 10, start_date: Date.strptime('10/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 70, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 3, bike_id: 170, subscription_type: 'Customer', zip_code: '94703')
      trip11 = Trip.create(duration: 1, start_date: Date.strptime('11/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 80, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 2, bike_id: 170, subscription_type: 'Customer', zip_code: '94703')
      trip12 = Trip.create(duration: 30, start_date: Date.strptime('12/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 67, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 1, bike_id: 100, subscription_type: 'Customer', zip_code: '94703')
      trip13 = Trip.create(duration: 5000, start_date: Date.strptime('1/29/2014 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1010, subscription_type: 'Customer', zip_code: '94703')

      # Expectations
      average_duration = Trip.average_duration
      longest_ride = Trip.longest_ride
      shortest_ride = Trip.shortest_ride
      busiest_starting_station = Trip.busiest_starting_station
      busiest_ending_station = Trip.busiest_ending_station
      monthly_ride_count = Trip.monthly_ride_count
      yearly_ride_count = Trip.yearly_ride_count
      most_popular_bike = Trip.most_popular_bike
      least_popular_bike = Trip.least_popular_bike
      subscriber_count = Trip.user_sub_type.find_by(subscription_type: "Subscriber").count
      subscriber_percent = subscriber_count / Trip.count.to_f
      customer_count = Trip.user_sub_type.find_by(subscription_type: "Customer").count
      customer_percent = customer_count / Trip.count.to_f
      busiest_date = Trip.busiest_date
      slowest_date = Trip.slowest_date
      # ----

      visit '/trips-dashboard'

      #Expectations
      expect(current_path).to eq('/trips-dashboard')
      expect(page).to have_content("Average Trip Duration: #{average_duration}")
      expect(page).to have_content("Trip #: #{longest_ride.id}")
      expect(page).to have_content("Duration: #{longest_ride.duration}")
      expect(page).to have_content("Trip #: #{shortest_ride.id}")
      expect(page).to have_content("Duration: #{shortest_ride.duration}")
      expect(page).to have_content("Starting Station: Station ##{busiest_starting_station.id}")
      expect(page).to have_content("Ending Station: Station ##{busiest_ending_station.id}")
      monthly_ride_count.each do |month_data|
        expect(page).to have_content("#{month_data.month.strftime('%B %Y')} Rides: #{month_data.count}")
      end
      yearly_ride_count.each do |year_data|
        expect(page).to have_content("#{year_data.year.strftime('%Y')} Rides: #{year_data.count}")
      end
      expect(page).to have_content("Most Ridden Bike: #{most_popular_bike.bike_id} (#{most_popular_bike.count} rides)")
      expect(page).to have_content("Least Ridden Bike: #{least_popular_bike.bike_id} (#{least_popular_bike.count} ride(s))")
      expect(page).to have_content("Number of users: #{subscriber_count}")
      expect(page).to have_content("% of all users: #{(subscriber_percent * 100).round(3)}")
      expect(page).to have_content("Number of users: #{customer_count}")
      expect(page).to have_content("% of all users: #{(customer_percent * 100).round(3)}")
      expect(page).to have_content("Busiest Date: #{busiest_date.date} (Ride Count: #{busiest_date.count}")
      expect(page).to have_content("Slowest Date: #{slowest_date.date} (Ride Count: #{slowest_date.count}")
    end
  end
end
