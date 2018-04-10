# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180410215408) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conditions", force: :cascade do |t|
    t.date "date"
    t.float "max_temperature_f"
    t.float "mean_temperature_f"
    t.float "min_temperature_f"
    t.float "max_dew_point_f"
    t.float "mean_dew_point_f"
    t.float "min_dew_point_f"
    t.float "max_humidity"
    t.float "mean_humidity"
    t.float "min_humidity"
    t.float "max_sea_level_pressure_inches"
    t.float "mean_sea_level_pressure_inches"
    t.float "min_sea_level_pressure_inches"
    t.float "max_visibility_miles"
    t.float "mean_visibility_miles"
    t.float "min_visibility_miles"
    t.float "max_wind_speed_mph"
    t.float "mean_wind_speed_mph"
    t.float "max_gust_speed_mph"
    t.float "precipitation_inches"
    t.float "cloud_cover"
    t.string "events"
    t.float "wind_dir_degrees"
    t.string "zip_code"
  end

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.integer "dock_count"
    t.string "city"
    t.datetime "installation_date"
    t.float "lat"
    t.float "long"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "duration"
    t.datetime "start_date"
    t.string "start_station_name"
    t.integer "start_station_id"
    t.datetime "end_date"
    t.string "end_station_name"
    t.integer "end_station_id"
    t.integer "bike_id"
    t.string "subscription_type"
    t.integer "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
  end

end
