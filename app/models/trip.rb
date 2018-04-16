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

    Station.find(busiest.first.start_station_id)
  end

  def self.busiest_ending_station
    busiest = select('end_station_id, count(end_station_id) as trips')
              .group('end_station_id')
              .order('trips DESC')
              .limit(1)

    Station.find(busiest.first.end_station_id)
  end

  def self.monthly_ride_count
    select("DATE_TRUNC('month', start_date) as month, count(*) as count")
    .group('month')
    .order('month')
  end

  def self.yearly_ride_count
    select("DATE_TRUNC('year', start_date) as year, count(*) as count")
    .group('year')
    .order('year')
  end

  def self.most_popular_bike
    select('bike_id, count(bike_id) as count')
    .group('bike_id')
    .order('count DESC')
    .first
  end

  def self.least_popular_bike
    select('bike_id, count(bike_id) as count')
    .group('bike_id')
    .order('count ASC')
    .first
  end

  def self.user_sub_type
    select('subscription_type, count(subscription_type) as count')
    .group('subscription_type')
    .order('count')
  end

  def self.busiest_date
    select('date(start_date) as date, count(start_date) as count')
    .group('date')
    .order('count DESC')
    .first
  end

  def self.slowest_date
    select('date(start_date) as date, count(start_date) as count')
    .group('date')
    .order('count DESC')
    .last
  end
end
