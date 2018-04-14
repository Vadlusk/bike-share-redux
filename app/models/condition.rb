class Condition < ApplicationRecord
  validates :date, presence: true

  def self.trips_by_temperature(range)
    joins("JOIN trips ON conditions.date = trips.start_date")
      .where(max_temperature_f: [range])
      .group("conditions.date")
      .count("trips.id")
  end

  def self.trips_by_precipitation(range)
    joins("JOIN trips ON conditions.date = trips.start_date")
      .where(precipitation_inches: [range])
      .group("conditions.date")
      .count("trips.id")
  end

  def self.trips_by_wind_speed(range)
    joins("JOIN trips ON conditions.date = trips.start_date")
      .where(mean_wind_speed_mph: [range])
      .group("conditions.date")
      .count("trips.id")
  end

  def self.min_trips_by_temperature
    breakdown = Hash.new(0)
    temperature_ranges.each do |key, value|
      breakdown[key] = return_min(trips_by_temperature(value))
    end
    breakdown
  end

  def self.max_trips_by_temperature
    breakdown = Hash.new(0)
    temperature_ranges.each.each do |key, value|
      breakdown[key] = return_max(trips_by_temperature(value))
    end
    breakdown
  end

  def self.avg_trips_by_temperature
    breakdown = Hash.new(0)
    temperature_ranges.each.each do |key, value|
      breakdown[key] = return_avg(trips_by_temperature(value))
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
    hash.values.sum / hash.keys.length
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
    {"0.00\" inches to 0.49\""=>0.00..0.49,
     "0.50\" inches to 0.99\""=>0.50..0.99,
     "1.00\" inches to 1.49\""=>1.00..1.49,
     "1.50\" inches to 1.99\""=>1.50..1.99,
     "2.00\" inches to 2.49\""=>2.00..2.49,
     "2.50\" inches to 2.99\""=>2.50..2.99,
     "3.00\" inches to 3.49\""=>3.00..3.49}
  end

  def self.wind_ranges
   {"0 mph to 3.99 mph"=>0..3.99,
    "4 mph to 7.99 mph"=>4..7.99,
    "8 mph to 11.99 mph"=>8..11.99,
    "12 mph to 15.99 mph"=>12..15.99,
    "16 mph to 19.99 mph"=>16..19.99,
    "20 mph to 23.99 mph"=>20..23.99,
    "24 mph to 27.99 mph"=>24..23.99,
    "28 mph to 31.99 mph"=>28..31.99,
    "32 mph to 35.99 mph"=>32..35.99,
    "36 mph to 39.99 mph"=>36..39.99,
    "40 mph to 43.99 mph"=>40..43.99}
  end

  def self.visibility_ranges
   {"0 miles to 3.99 miles"=>0..3.99,
    "4 miles to 7.99 miles"=>4..7.99,
    "8 miles to 11.99 miles"=>8..11.99,
    "12 miles to 15.99 miles"=>12..15.99,
    "16 miles to 19.99 miles"=>16..19.99,
    "20 miles to 23.99 miles"=>20..23.99}
  end
end



# def self.trips_by_temperature_breakdown
#   breakdown = Hash.new(0)
#   temperature_ranges.each do |key, value|
#     breakdown[key] = trips_by_temperature(value)
#   end
#   breakdown
# end
