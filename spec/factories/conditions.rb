FactoryBot.define do
  factory Condition do
    date Time.now
    sequence(:max_temp) { rand(60..80)}
    sequence(:mean_temp) { rand(50..70)}
    sequence(:min_temp) { rand(40..60)}
    sequence(:max_dew_point) { rand(40..60)}
    sequence(:mean_dew_point) { rand(40..50)}
    sequence(:min_dew_point) { rand(30..40)}
    sequence(:max_humidity) { rand(75..100)}
    sequence(:mean_humidity) { rand(50..90)}
    sequence(:min_humidity) { rand(10..60)}
    sequence(:max_sea_lvl_pressure) { rand(29.95..30.22)}
    sequence(:mean_sea_lvl_pressure) { rand(30.00..30.15)}
    sequence(:min_sea_lvl_pressure) { rand(29.80..29.95)}
    max_visibility 10
    sequence(:mean_visibility) { rand(5..10)}
    sequence(:min_visibility) { rand(0..10)}
    sequence(:max_wind_speed) { rand(7..30)}
    sequence(:mean_wind_speed) { rand(1..15)}
    sequence(:max_gust_speed) { rand(6..40)}
    sequence(:precip) { rand(0..2)}
    sequence(:cloud_cover) { rand(0..7)}
    sequence(:events) { ['fog', 'rain', ' '].sample }
    sequence(:wind_dir_degrees) { rand(0..360)}
    sequence(:zip_code) { rand(10000..99999)}
  end
end
