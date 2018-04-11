FactoryBot.define do
  factory :condition do
    date Time.now
    sequence(:max_temperature_f) { rand(60..80)}
    sequence(:mean_temperature_f) { rand(50..70)}
    sequence(:min_temperature_f) { rand(40..60)}
    sequence(:max_dew_point_f) { rand(40..60)}
    sequence(:mean_dew_point_f) { rand(40..50)}
    sequence(:min_dew_point_f) { rand(30..40)}
    sequence(:max_humidity) { rand(75..100)}
    sequence(:mean_humidity) { rand(50..90)}
    sequence(:min_humidity) { rand(10..60)}
    sequence(:max_sea_level_pressure_inches) { rand(29.95..30.22).round(2)}
    sequence(:mean_sea_level_pressure_inches) { rand(30.00..30.15).round(2)}
    sequence(:min_sea_level_pressure_inches) { rand(29.80..29.95).round(2)}
    max_visibility_miles 10
    sequence(:mean_visibility_miles) { rand(5..10)}
    sequence(:min_visibility_miles) { rand(0..10)}
    sequence(:max_wind_Speed_mph) { rand(7..30)}
    sequence(:mean_wind_speed_mph) { rand(1..15)}
    sequence(:max_gust_speed_mph) { rand(6..40)}
    sequence(:precipitation_inches) { rand(0..2)}
    sequence(:cloud_cover) { rand(0..7)}
    sequence(:events) { ['fog', 'rain', ' '].sample }
    sequence(:wind_dir_degrees) { rand(0..360)}
    sequence(:zip_code) { rand(10000..99999)}
  end
end
