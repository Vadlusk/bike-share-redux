require 'rails_helper'

describe 'Admin' do
  context 'visits the trips dashboard' do
    scenario 'and it has all analysis information' do
      stations = create_list(:station, 100)

      trip1 = Trip.create(duration: 1000, start_date: Date.strptime('1/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 10, subscription_type: 'Subscriber', zip_code: '94703')
      trip2 = Trip.create(duration: 90, start_date: Date.strptime('2/27/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 1, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 11, bike_id: 100, subscription_type: 'Subscriber', zip_code: '94703')
      trip3 = Trip.create(duration: 100, start_date: Date.strptime('3/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 9, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 10, bike_id: 1000, subscription_type: 'Subscriber', zip_code: '94703')
      trip4 = Trip.create(duration: 300, start_date: Date.strptime('4/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 10, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 9, bike_id: 9, subscription_type: 'Subscriber', zip_code: '94703')
      trip5 = Trip.create(duration: 40, start_date: Date.strptime('5/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 90, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 8, bike_id: 8, subscription_type: 'Subscriber', zip_code: '94703')
      trip6 = Trip.create(duration: 4000, start_date: Date.strptime('6/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 30, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 7, bike_id: 17, subscription_type: 'Subscriber', zip_code: '94703')
      trip7 = Trip.create(duration: 7000, start_date: Date.strptime('7/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 40, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 6, bike_id: 1080, subscription_type: 'Subscriber', zip_code: '94703')
      trip8 = Trip.create(duration: 9000, start_date: Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 50, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 5, bike_id: 180, subscription_type: 'Subscriber', zip_code: '94703')
      trip9 = Trip.create(duration: 10_000, start_date: Date.strptime('9/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 60, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 4, bike_id: 1600, subscription_type: 'Customer', zip_code: '94703')
      trip10 = Trip.create(duration: 10, start_date: Date.strptime('10/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 70, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 3, bike_id: 170, subscription_type: 'Customer', zip_code: '94703')
      trip11 = Trip.create(duration: 1, start_date: Date.strptime('11/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 80, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 2, bike_id: 1030, subscription_type: 'Customer', zip_code: '94703')
      trip12 = Trip.create(duration: 30, start_date: Date.strptime('12/29/2013 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 67, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 1, bike_id: 1200, subscription_type: 'Customer', zip_code: '94703')
      trip13 = Trip.create(duration: 5000, start_date: Date.strptime('1/29/2014 9:08', '%m/%d/%Y %k:%M'), start_station_name: '2nd at South Park', start_station_id: 100, end_date: Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M'), end_station_name: '2nd at South Park', end_station_id: 100, bike_id: 1010, subscription_type: 'Customer', zip_code: '94703')

      # Expectations
      average_duration = Trip.average_duration
      longest_ride = Trip.longest_ride
      shortest_ride = Trip.shortest_ride
      busiest_starting_station = Trip.busiest_starting_station
      busiest_ending_station = Trip.busiest_ending_station
      monthly_ride_count = [Trip.monthly_ride_count[1.0],
                            Trip.monthly_ride_count[2.0],
                            Trip.monthly_ride_count[3.0],
                            Trip.monthly_ride_count[4.0],
                            Trip.monthly_ride_count[5.0],
                            Trip.monthly_ride_count[6.0],
                            Trip.monthly_ride_count[7.0],
                            Trip.monthly_ride_count[8.0],
                            Trip.monthly_ride_count[9.0],
                            Trip.monthly_ride_count[10.0],
                            Trip.monthly_ride_count[11.0],
                            Trip.monthly_ride_count[12.0]]

      yearly_ride_count = [Trip.yearly_ride_count[2013.0],
                           Trip.yearly_ride_count[2014.0]]

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
      expect(page).to have_content(longest_ride)
      expect(page).to have_content(shortest_ride)
      expect(page).to have_content(busiest_starting_station)
      expect(page).to have_content(busiest_ending_station)
      monthly_ride_count.each do |month|
        expect(page).to have_content(month.count)
      end
      yearly_ride_count.each do |year|
        expect(page).to have_content(year.count)
      end
      expect(page).to have_content(most_popular_bike.bike_id)
      expect(page).to have_content(most_popular_bike.count)
      expect(page).to have_content(least_popular_bike.bike_id)
      expect(page).to have_content(least_popular_bike.count)
      expect(page).to have_content(subscriber_count)
      expect(page).to have_content(subscriber_percent)
      expect(page).to have_content(customer_count)
      expect(page).to have_content(customer_percent)
      expect(page).to have_content(busiest_date.date)
      expect(page).to have_content(busiest_date.count)
      expect(page).to have_content(slowest_date.date)
      expect(page).to have_content(slowest_date.count)
    end
  end
end
