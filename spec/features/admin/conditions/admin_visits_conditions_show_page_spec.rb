require 'rails_helper'

describe 'Visitor' do
  context 'as a registered admin user' do
    it 'can visit conditions show and see all same condition information as default user' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

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

    it 'can visit conditions show and see edit and delete buttons' do
      admin = create(:admin)
      condition = create(:condition)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit condition_path(condition)

      expect(page).to have_css(".card-buttons")
    end
  end

  context 'as a registered default user' do
    it 'can visit conditions index and does not see edit and delete buttons' do
      user = create(:user)
      condition = create(:condition)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit condition_path(condition)

      expect(page).to_not have_css(".card-buttons")
    end
  end
end
