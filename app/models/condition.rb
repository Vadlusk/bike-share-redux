class Condition < ApplicationRecord
  validates :date, presence: true

  def self.trips_by_temperature(range)
    joins("JOIN trips ON conditions.date = trips.start_date")
      .where(max_temperature_f: [range])
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

  def self.return_min(hash)
    hash.min_by{ |key, value| value }
  end

  def self.return_max(hash)
    hash.max_by{ |key, value| value }
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
end



# def self.trips_by_temperature_breakdown
#   breakdown = Hash.new(0)
#   temperature_ranges.each do |key, value|
#     breakdown[key] = trips_by_temperature(value)
#   end
#   breakdown
# end
