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

Station.destroy_all
Trip.destroy_all
Condition.destroy_all

def zip_cleaner(zip)
  if zip
    zip.to_s[0, 5]
  else
    "00000"
  end
end

CSV.foreach('db/csv/station.csv', headers: true) do |row|
  row["installation_date"] = Date.strptime(row["installation_date"], '%m/%d/%Y')
  Station.create!(row.to_h)
end


CSV.foreach('db/csv/trip.csv', headers: true).with_index do |row, index|
  break if index >= 1000
  row["start_date"] = Date.strptime(row["start_date"], '%m/%d/%Y %k:%M')
  row["end_date"] =  Date.strptime(row["end_date"], '%m/%d/%Y %k:%M')
  row["zip_code"] = zip_cleaner(row["zip_code"])
  Trip.create!(row.to_h)
  puts "Created trip #{index + 1}"
end

CSV.foreach('db/csv/weather.csv', headers: true) do |row|
  row["date"] = Date.strptime(row["date"], '%m/%d/%Y')
  Condition.create!(row.to_h)
end
Accessory
