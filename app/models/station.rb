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

  has_many :start_trips, class_name: "Trip", foreign_key: "start_station_id"
  has_many :end_trips, class_name: "Trip", foreign_key: "end_station_id"

  def generate_slug
    self.slug = name.parameterize
  end

  def to_param
    slug
  end

  def num_rides_started
    start_trips.count
  end

  def num_rides_ended
    end_trips.count
  end

  def frequent_destination
    start_trips.select('end_station_name, count(end_station_name) as count')
    .group('end_station_name')
    .order('count DESC')
    .first
    .end_station_name
  end

  def frequent_origination
    end_trips.select('start_station_name, count(start_station_name) as count')
    .group('start_station_name')
    .order('count DESC')
    .first
    .start_station_name
  end

  def busiest_date
    start_trips.select('start_date, count(start_date) as count')
    .group('start_date')
    .order('count DESC')
    .first
    .start_date
  end

  def busiest_zip_code
    start_trips.select('zip_code, count(zip_code) as count')
    .group('zip_code')
    .order('count DESC')
    .first
    .zip_code
  end

  def busiest_bike
    start_trips.select('bike_id, count(bike_id) as count')
    .group('bike_id')
    .order('count DESC')
    .first
    .bike_id
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
end
