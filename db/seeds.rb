# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# stations = Hash.new
# CSV.foreach('db/csv/station.csv', headers: true) do |row|
#   break if row["id"].to_i >= 10
#   stations[row["id"]] = []
# end
#
# stations.each do |station|
#   station[1].each_with_index do |row, index|
#     break if index == 100
#     Status.create!(row.to_h)
#   end
# end

CSV.foreach('db/csv/station.csv', headers: true) do |row|
  Station.create!(row.to_h)
end


CSV.foreach('db/csv/trip.csv', headers: true).with_index do |row, index|
  break if index >= 1000
  Trip.create!(row.to_h)
  puts "Created trip #{index + 1}"
end

CSV.foreach('db/csv/weather.csv', headers: true) do |row|
  Condition.create!(row.to_h)
end

# CSV.foreach('db/csv/status.csv', headers: true).with_index do |row, index|
#   break if row["station_id"].to_i >= 10
#   stations[row["station_id"]] << row
# end
