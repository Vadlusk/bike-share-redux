require 'date'

FactoryBot.define do
  factory :station do
    name { ['2nd at South Park', 'San Francisco Caltrain 2 (330 Townsend)', 'South Van Ness at Market', 'Mountain View City Hall'] }
    dock_count { rand(1..30) }
    city { ['San Jose', 'Mountain View', 'Palo Alto', 'San Francisco'] }
    installation_date Date.strptime('8/29/2013 9:08', '%m/%d/%Y %k:%M')
  end
end
