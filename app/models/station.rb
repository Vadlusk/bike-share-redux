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

  def self.total_stations
    count
  end

  def self.average_bikes
    average(:dock_count)
  end

  def self.most_bikes
    maximum(:dock_count)
  end

  def self.fewest_bikes
    minimum(:dock_count)
  end

  def self.most_station
    [].push(Station.find_by(dock_count: most_bikes))
  end
end
