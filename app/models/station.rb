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
    Trip.where(start_station_id: id).count
  end

  def num_rides_ended
    Trip.where(end_station_id: id).count
  end

  def frequent_destination
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
    Station.where(dock_count: most_bikes)
  end

  def self.fewest_station
    Station.where(dock_count: fewest_bikes)
  end

  def self.newest_station
    Station.order(:installation_date).last
  end

  def self.oldest_station
    Station.order(:installation_date).first
  end
end
