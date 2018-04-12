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
end
