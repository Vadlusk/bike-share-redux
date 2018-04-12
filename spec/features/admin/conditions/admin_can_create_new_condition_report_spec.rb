require 'rails_helper'

describe 'Visitor' do
  context 'as a registered admin user' do
    it 'can create a new condition report' do
      admin = create(:admin)
      date = "11/11/2011"
      max_temp = 1000
      mean_temp = 2000
      min_temp = 3000
      max_dew = 3250
      mean_dew = 3350
      min_dew = 3450
      max_humidity = 3500
      mean_humidity = 3650
      min_humidity = 3750
      max_sea_level = 3850
      mean_sea_level = 3950
      min_sea_level = 3975
      max_visibility = 3985
      mean_visibility = 3990
      min_visibility = 3995
      max_wind_speed = 4000
      mean_wind_speed = 4005
      max_gust_speed = 4010
      precipitation = 4015
      cloud_cover = 4020
      events = 'rain'
      wind_dir = 180
      zip = 80205

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_condition_path

      fill_in 'condition[date]', with: date
      fill_in 'condition[max_temperature_f]', with: max_temp
      fill_in 'condition[mean_temperature_f]', with: mean_temp
      fill_in 'condition[min_temperature_f]', with: min_temp
      fill_in 'condition[max_dew_point_f]', with: max_dew
      fill_in 'condition[mean_dew_point_f]', with: mean_dew
      fill_in 'condition[min_dew_point_f]', with: min_dew
      fill_in 'condition[max_humidity]', with: max_humidity
      fill_in 'condition[mean_humidity]', with: mean_humidity
      fill_in 'condition[min_humidity]', with: min_humidity
      fill_in 'condition[max_sea_level_pressure_inches]', with: max_sea_level
      fill_in 'condition[mean_sea_level_pressure_inches]', with: mean_sea_level
      fill_in 'condition[min_sea_level_pressure_inches]', with: min_sea_level
      fill_in 'condition[max_visibility_miles]', with: max_visibility
      fill_in 'condition[mean_visibility_miles]', with: mean_visibility
      fill_in 'condition[min_visibility_miles]', with: min_visibility
      fill_in 'condition[max_wind_Speed_mph]', with: max_wind_speed
      fill_in 'condition[mean_wind_speed_mph]', with: mean_wind_speed
      fill_in 'condition[max_gust_speed_mph]', with: max_gust_speed
      fill_in 'condition[precipitation_inches]', with: precipitation
      fill_in 'condition[cloud_cover]', with: cloud_cover
      fill_in 'condition[events]', with: events
      fill_in 'condition[wind_dir_degrees]', with: wind_dir
      fill_in 'condition[zip_code]', with: zip
      click_on 'Create Condition'

      expect(current_path).to eq(condition_path(Condition.last.id))

      expect(page).to have_content("November 11, 2011")
      expect(page).to have_content(max_temp)
      expect(page).to have_content(mean_temp)
      expect(page).to have_content(min_temp)
      expect(page).to have_content(mean_humidity)
      expect(page).to have_content(mean_visibility)
      expect(page).to have_content(mean_wind_speed)
      expect(page).to have_content(precipitation)
    end
  end
end
