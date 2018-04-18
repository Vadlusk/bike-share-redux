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
Accessory.destroy_all
User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!(:stations)
ActiveRecord::Base.connection.reset_pk_sequence!(:conditions)
ActiveRecord::Base.connection.reset_pk_sequence!(:users)
ActiveRecord::Base.connection.reset_pk_sequence!(:accessories)
ActiveRecord::Base.connection.reset_pk_sequence!(:trips)
ActiveRecord::Base.connection.reset_pk_sequence!(:order_accessories)
ActiveRecord::Base.connection.reset_pk_sequence!(:orders)

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


CSV.foreach('db/csv/trip-trunc.csv', headers: true) do |row|
  row["start_date"] = Date.strptime(row["start_date"], '%m/%d/%Y %k:%M')
  row["end_date"] =  Date.strptime(row["end_date"], '%m/%d/%Y %k:%M')
  row["zip_code"] = zip_cleaner(row["zip_code"])
  Trip.create!(row.to_h)
end

CSV.foreach('db/csv/weather.csv', headers: true) do |row|
  row["date"] = Date.strptime(row["date"], '%m/%d/%Y')
  Condition.create!(row.to_h)
end

accessory1 = Accessory.create!(title: "Helmet", description: "Protects your noggin", price: 100.00, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
accessory2 = Accessory.create!(title: "Seat", description: "Protects your butt", price: 100.00, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
accessory3 = Accessory.create!(title: "Wheel", description: "Protects the road", price: 100.00, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
Accessory.create!(title: "Cleats", description: "Protects your feet", price: 100.00, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
Accessory.create!(title: "Bag", description: "Protects your stuff", price: 100.00, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
Accessory.create!(title: "Light", description: "Protects your life", price: 100.00, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
Accessory.create!(title: "Spoke", description: "Protects your wheels", price: 100.00, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
Accessory.create!(title: "Bell", description: "Protects you from others", price: 100.00, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
Accessory.create!(title: "Bib", description: "Protects your butt", price: 100.00, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
Accessory.create!(title: "Jersey", description: "Protects your torso", price: 100.00, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
Accessory.create!(title: "Gloves", description: "Protects your hands", price: 100.00, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
Accessory.create!(title: "Socks", description: "Protects your shoes from sweat", price: 100.00, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
Accessory.create!(title: "Gummies", description: "Protects your stomach", price: 100.00, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
Accessory.create!(title: "retired", description: "Protects nothing", price: 100.00, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 1)

admin = User.create!(username: "admin", email: "admin@admin.com", password: "password", role: 1)
user = User.create!(username: "default", email: "default@default.com", password: "password")

15.times do
  order = Order.create!(user_id: admin.id, status: [0,1,2,3].sample)
  OrderAccessory.create!(quantity: [1,2,3].sample, order_id: order.id, accessory_id: accessory1.id)
  OrderAccessory.create!(quantity: [1,2,3].sample, order_id: order.id, accessory_id: accessory2.id)
  OrderAccessory.create!(quantity: [1,2,3].sample, order_id: order.id, accessory_id: accessory3.id)
end

15.times do
  order = Order.create!(user_id: user.id, status: [0,1,2,3].sample)
  OrderAccessory.create!(quantity: [1,2,3].sample, order_id: order.id, accessory_id: accessory1.id)
  OrderAccessory.create!(quantity: [1,2,3].sample, order_id: order.id, accessory_id: accessory2.id)
  OrderAccessory.create!(quantity: [1,2,3].sample, order_id: order.id, accessory_id: accessory3.id)
end

ActiveRecord::Base.connection.reset_pk_sequence!(:stations)
ActiveRecord::Base.connection.reset_pk_sequence!(:conditions)
ActiveRecord::Base.connection.reset_pk_sequence!(:users)
ActiveRecord::Base.connection.reset_pk_sequence!(:accessories)
ActiveRecord::Base.connection.reset_pk_sequence!(:trips)
ActiveRecord::Base.connection.reset_pk_sequence!(:order_accessories)
ActiveRecord::Base.connection.reset_pk_sequence!(:orders)
