require 'rails_helper'

describe 'user' do
  context 'as an admin' do
    it 'sees delete button in station show' do
      station = create(:station)
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit station_path(station)

      expect(page).to have_css(".table-buttons")
    end

    it 'does not show delete button to non-admin' do
      station = create(:station)
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit station_path(station)

      expect(page).to_not have_css(".table-buttons")
    end

    it 'admin can delete a station by clicking button' do
      station = create(:station)

      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit station_path(station)

      find(:xpath, ".//a[i[contains(@class, 'far fa-trash-alt')]]").click

      expect(current_path).to eq(stations_path)
      expect(page).to have_content("You deleted the station successfully.")
      expect(page).to_not have_content(station.name)
    end

  end
end
