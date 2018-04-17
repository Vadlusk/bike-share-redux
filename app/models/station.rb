class Station < ApplicationRecord
  validates_presence_of :name,
                        :dock_count,
                        :city,
                        :installation_date,
                        :lat,
                        :long

  before_save :generate_slug
  validates :lat, :inclusion => -90..90
  validates :long, :inclusion => -180..180

  def generate_slug
    self.slug = name.parameterize
  end

  def to_param
    slug
  end

  def num_rides_started
    starting_trips.count
  end

  def num_rides_ended
    ending_trips.count
  end

  def frequent_destination
    starting_trips.select('end_station_name, count(end_station_name) as count')
    .group('end_station_name')
    .order('count DESC')
    .first
  end

  def frequent_origination
    ending_trips.select('start_station_name, count(start_station_name) as count')
    .group('start_station_name')
    .order('count DESC')
    .first
  end

  def busiest_date
    starting_trips.select('start_date, count(start_date) as count')
    .group('start_date')
    .order('count DESC')
    .first
  end

  def busiest_zip_code
    starting_trips.select('zip_code, count(zip_code) as count')
    .group('zip_code')
    .order('count DESC')
    .first
  end

  def busiest_bike
    starting_trips.select('bike_id, count(bike_id) as count')
    .group('bike_id')
    .order('count DESC')
    .first
  end

  def self.total_stations
    count
  end

  def self.average_bikes
    average(:dock_count).round(2)
  end

  def self.most_bikes
    maximum(:dock_count)
  end

  def self.fewest_bikes
    minimum(:dock_count)
  end

  def self.most_station
    where(dock_count: most_bikes)
  end

  def self.fewest_station
    where(dock_count: fewest_bikes)
  end

  def self.newest_station
    order(:installation_date).last
  end

  def self.oldest_station
    order(:installation_date).first
  end

  private

    def starting_trips
      Trip.where(start_station_id: id)
    end

    def ending_trips
      Trip.where(end_station_id: id)
    end
end
