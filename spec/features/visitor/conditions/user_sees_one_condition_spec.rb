require 'rails_helper'

describe 'user sees one condition' do
  scenario 'and its information' do
    condition = create(:condition)

    visit condition_path(condition)

    expect(page).to have_content(condition.date.strftime("%B %d, %Y"))
    expect(page).to have_content(condition.max_temperature_f)
    expect(page).to have_content(condition.mean_temperature_f)
    expect(page).to have_content(condition.min_temperature_f)
    expect(page).to have_content(condition.mean_humidity)
    expect(page).to have_content(condition.mean_visibility_miles)
    expect(page).to have_content(condition.mean_wind_speed_mph)
    expect(page).to have_content(condition.precipitation_inches)
  end
end
