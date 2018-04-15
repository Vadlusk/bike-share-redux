class Condition < ApplicationRecord
  validates :date, presence: true

  def self.trips_by_temperature(*range)
    joins("JOIN trips ON conditions.date = trips.start_date")
      .where(max_temperature_f: [range])
      .group("conditions.date")
      .count("trips.id")
  end

  def self.trips_by_precipitation(*range)
    joins("JOIN trips ON conditions.date = trips.start_date")
      .where(precipitation_inches: [range])
      .group("conditions.date")
      .count("trips.id")
  end

  def self.trips_by_wind_speed(*range)
    joins("JOIN trips ON conditions.date = trips.start_date")
      .where(mean_wind_speed_mph: [range])
      .group("conditions.date")
      .count("trips.id")
  end

  def self.trips_by_visibility(*range)
    joins("JOIN trips ON conditions.date = trips.start_date")
      .where(mean_visibility_miles: [range])
      .group("conditions.date")
      .count("trips.id")
  end

  def self.min_trips_by(ranges, trips)
    breakdown = Hash.new(0)
    ranges.each do |key, value|
      breakdown[key] = return_min(send(trips, value))
    end
    breakdown
  end

  def self.max_trips_by(ranges, trips)
    breakdown = Hash.new(0)
    ranges.each do |key, value|
      breakdown[key] = return_max(send(trips, value))
    end
    breakdown
  end

  def self.avg_trips_by(ranges, trips)
    breakdown = Hash.new(0)
    ranges.each do |key, value|
      breakdown[key] = return_avg(send(trips, value))
    end
    breakdown
  end

  def self.return_min(hash)
    return [nil, 0] if hash.empty?
    hash.min_by{ |key, value| value }
  end

  def self.return_max(hash)
    return [nil, 0] if hash.empty?
    hash.max_by{ |key, value| value }
  end

  def self.return_avg(hash)
    return 0 if hash.empty?
    (hash.values.sum / hash.keys.length.to_f).round(2)
  end

  def self.temperature_ranges
    {"40°F to 49°F"=>40..49,
     "50°F to 59°F"=>50..59,
     "60°F to 69°F"=>60..69,
     "70°F to 79°F"=>70..79,
     "80°F to 89°F"=>80..89,
     "90°F to 99°F"=>90..99,
     "100°F to 110°F"=>100..110}
  end

  def self.precipitation_ranges
    {"0.00\" to 0.49\""=>0.00..0.49,
     "0.50\" to 0.99\""=>0.50..0.99,
     "1.00\" to 1.49\""=>1.00..1.49,
     "1.50\" to 1.99\""=>1.50..1.99,
     "2.00\" to 2.49\""=>2.00..2.49,
     "2.50\" to 2.99\""=>2.50..2.99,
     "3.00\" to 3.49\""=>3.00..3.49}
  end

  def self.wind_ranges
   {"0 mph to 4 mph"=>0..4,
    "5 mph to 9 mph"=>5..9,
    "10 mph to 14 mph"=>10..14,
    "15 mph to 19 mph"=>15..19,
    "20 mph to 24 mph"=>20..24,
    "25 mph to 29 mph"=>25..29,
    "30 mph to 34 mph"=>30..35,
    "35 mph to 39 mph"=>35..39,
    "40 mph to 44 mph"=>40..44,
    "45 mph to 49 mph"=>45..49}
  end

  def self.visibility_ranges
   {"0 miles to 4 miles"=>0..4,
    "5 miles to 9 miles"=>5..9,
    "10 miles to 14 miles"=>10..14,
    "15 miles to 19 miles"=>15..19,
    "20 miles to 24 miles"=>20..24,
    "25 miles to 29 miles"=>25..29}
  end
end
