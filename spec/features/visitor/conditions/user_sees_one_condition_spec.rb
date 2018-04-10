require 'rails_helper'

describe 'user sees one condition' do
  scenario 'and its information' do
    condition = create(:condition)

    visit condition_path(condition)

    expect(page).to have_content(condition.date)
    expect(page).to have_content(condition.max_temperature_f)
    expect(page).to have_content(condition.mean_temperature_f)
    expect(page).to have_content(condition.min_temperature_f)
    expect(page).to have_content(condition.max_dew_point_f)
    expect(page).to have_content(condition.mean_dew_point_f)
    expect(page).to have_content(condition.min_dew_point_f)
    expect(page).to have_content(condition.max_humidity)
    expect(page).to have_content(condition.mean_humidity)
    expect(page).to have_content(condition.min_humidity)
    expect(page).to have_content(condition.max_sea_level_pressure_inches)
    expect(page).to have_content(condition.mean_sea_level_pressure_inches)
    expect(page).to have_content(condition.min_sea_level_pressure_inches)
    expect(page).to have_content(condition.max_visibility_miles)
    expect(page).to have_content(condition.mean_visibility_miles)
    expect(page).to have_content(condition.min_visibility_miles)
    expect(page).to have_content(condition.max_wind_Speed_mph)
    expect(page).to have_content(condition.mean_wind_speed_mph)
    expect(page).to have_content(condition.max_gust_speed_mph)
    expect(page).to have_content(condition.precipitation_inches)
    expect(page).to have_content(condition.cloud_cover)
    expect(page).to have_content(condition.events)
    expect(page).to have_content(condition.wind_dir_degrees)
    expect(page).to have_content(condition.zip_code)
  end
end
