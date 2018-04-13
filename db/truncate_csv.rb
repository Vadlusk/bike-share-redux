require 'csv'
require 'pry'

# def zip_cleaner(zip)
#   if zip
#     zip.to_s[0, 5]
#   else
#     "00000"
#   end
# end

# csv = CSV.open('db/csv-truncated/trip-trunc.csv')

CSV.open('db/csv-truncated/trip-trunc.csv', "a+") do |csv|
  csv << ["id","duration","start_date","start_station_name","start_station_id","end_date","end_station_name","end_station_id","bike_id","subscription_type","zip_code"]
end

CSV.foreach('db/csv/trip.csv', headers: true).with_index do |row, index|
  next if index.zero?
  break if index >= 1000
  CSV.open('db/csv-truncated/trip-trunc.csv', "a+") do |csv|
    csv << [row["id"],row["duration"],row["start_date"],row["start_station_name"],row["start_station_id"],row["end_date"],row["end_station_name"],row["end_station_id"],row["bike_id"],row["subscription_type"],row["zip_code"]]
  end
end
#
#
# CSV.foreach('db/csv/trip.csv', headers: true).with_index do |row, index|
#   break if index >= 1000
#   row["start_date"] = Date.strptime(row["start_date"], '%m/%d/%Y %k:%M')
#   row["end_date"] =  Date.strptime(row["end_date"], '%m/%d/%Y %k:%M')
#   row["zip_code"] = zip_cleaner(row["zip_code"])
#   Trip.create!(row.to_h)
#   puts "Created trip #{index + 1}"
# end
#
# CSV.foreach('db/csv/weather.csv', headers: true) do |row|
#   row["date"] = Date.strptime(row["date"], '%m/%d/%Y')
#   Condition.create!(row.to_h)
# end
