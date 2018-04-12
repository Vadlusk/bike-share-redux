require 'rails_helper'

describe 'Visitor' do
  context 'as a registered admin user' do
    it 'can visit conditions index and see all same condition information as default user' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

<<<<<<< HEAD
      conditions = create_list(:condition, 5)
=======
      conditions = create_list(:condition, 10)
>>>>>>> Add admin conditions edit functionality

      visit conditions_path

      conditions.each do |condition|
        expect(page).to have_content(condition.date)
        expect(page).to have_content(condition.max_temperature_f)
        expect(page).to have_content(condition.mean_temperature_f)
        expect(page).to have_content(condition.min_temperature_f)
        expect(page).to have_content(condition.mean_humidity)
        expect(page).to have_content(condition.mean_visibility_miles)
<<<<<<< HEAD
=======
        expect(page).to have_content(condition.min_visibility_miles)
>>>>>>> Add admin conditions edit functionality
        expect(page).to have_content(condition.mean_wind_speed_mph)
        expect(page).to have_content(condition.precipitation_inches)
      end
    end

    it 'can visit conditions index and see edit and delete buttons' do
      admin = create(:admin)
      condition = create(:condition)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit conditions_path

      expect(page).to have_css(".table-buttons")
    end

    it 'can click edit button and navigate to conditions edit path' do
      admin = create(:admin)
      condition = create(:condition)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit conditions_path

      within(".condition-#{condition.id}") do
        find(:xpath, ".//a[i[contains(@class, 'far fa-edit')]]").click
      end

      expect(current_path).to eq(edit_admin_condition_path(condition))
    end
  end

  context 'as a registered default user' do
    it 'can visit conditions index and does not see edit and delete buttons' do
      user = create(:user)
      condition = create(:condition)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit conditions_path

      expect(page).to_not have_css(".table-buttons")
    end
  end
end
