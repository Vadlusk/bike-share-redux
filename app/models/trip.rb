class Trip < ApplicationRecord
  validates :duration,
            :start_date,
            :start_station_name,
            :start_station_id,
            :end_date,
            :end_station_name,
            :end_station_id,
            :bike_id,
            :subscription_type,
            :zip_code, presence: true

  def self.average_duration
    average(:duration).to_i
  end

  def self.longest_ride
    find_by(duration: maximum(:duration))
  end

  def self.shortest_ride
    find_by(duration: minimum(:duration))
  end

  def self.busiest_starting_station
    busiest = select('start_station_id, count(start_station_id) as trips')
              .group('start_station_id')
              .order('trips DESC')
              .limit(1)
    # binding.pry
    Station.find(busiest.first.start_station_id)
  end
end
