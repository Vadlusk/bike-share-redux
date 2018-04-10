require 'date'

FactoryBot.define do
  factory :trip do
    duration { rand(1..1000) }
    start_date Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
    start_station_name { ['2nd at South Park', 'San Francisco Caltrain 2 (330 Townsend)', 'South Van Ness at Market', 'Mountain View City Hall'].sample }
    start_station_id { rand(1..100) }
    end_date Date.strptime('8/29/2013 9:11', '%m/%d/%Y %k:%M')
    end_station_name { ['2nd at South Park', 'San Francisco Caltrain 2 (330 Townsend)', 'South Van Ness at Market', 'Mountain View City Hall'].sample }
    end_station_id { rand(1..100) }
    bike_id { rand(1..1000) }
    subscription_type { %w[Subscriber Customer].sample }
    zip_code '94703'
  end
end
