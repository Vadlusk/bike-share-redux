require 'rails_helper'

describe 'user sees all conditions' do
  scenario 'and all their attributes' do
    conditions = create_list(:condition, 10)

    visit conditions_path

    conditions.each do |condition|
      expect(page).to have_content(condition.date)
      expect(page).to have_content(condition.max_temperature_f)
      expect(page).to have_content(condition.mean_temperature_f)
      expect(page).to have_content(condition.min_temperature_f)
      expect(page).to have_content(condition.mean_humidity)
      expect(page).to have_content(condition.mean_visibility_miles)
      expect(page).to have_content(condition.min_visibility_miles)
      expect(page).to have_content(condition.mean_wind_speed_mph)
      expect(page).to have_content(condition.precipitation_inches)
    end
  end
end
