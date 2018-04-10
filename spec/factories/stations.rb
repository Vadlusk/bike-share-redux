require 'date'

FactoryBot.define do
  factory :station do
    sequence(:name) { ['2nd at South Park', 'San Francisco Caltrain 2 (330 Townsend)', 'South Van Ness at Market', 'Mountain View City Hall'].sample }
    dock_count { rand(1..30) }
    sequence(:city) { ['San Jose', 'Mountain View', 'Palo Alto', 'San Francisco'].sample }
    installation_date Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
    latitude { rand(-90..90) }
    longitude { rand(-180..180) }
  end
end
