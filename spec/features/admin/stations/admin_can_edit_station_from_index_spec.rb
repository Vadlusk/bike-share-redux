require 'rails_helper'

describe 'user' do
  context 'as an admin' do
    it 'sees edit button in station index' do
      create_list(:station, 10)

      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit stations_path

      expect(page).to have_css(".table-buttons")
    end

    it 'does not show edit button to non-admin' do
      create_list(:station, 10)

      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit stations_path

      expect(page).to_not have_css(".table-buttons")
    end

    it 'admin can get to station edit page by clicking button' do
      create_list(:station, 10)
      station = create(:station)

      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit stations_path

      within(".station-#{station.id}") do
        find(:xpath, ".//a[i[contains(@class, 'far fa-edit')]]").click
      end

      expect(current_path).to eq(edit_admin_station_path(station))
    end

    it 'admin can get edit station by clicking button' do
      create_list(:station, 10)
      station = create(:station, name: 'Grrblllball')

      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit stations_path
      expect(page).to have_content('Grrblllball')

      within(".station-#{station.id}") do
        find(:xpath, ".//a[i[contains(@class, 'far fa-edit')]]").click
      end

      fill_in 'station[name]', with: 'Awesome Bike Place'
      click_on 'Update Station'

      expect(current_path).to eq('/stations/awesome-bike-place')
      expect(page).to have_content('This station has been updated.')
      expect(page).to_not have_content('Grrblllball')
      expect(page).to have_content('Awesome Bike Place')
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.built)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.lat)
      expect(page).to have_content(station.long)
    end

    it 'admin cannot edit with improper lat or long' do
      station = create(:station)

      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit edit_admin_station_path(station)

      fill_in 'station[lat]', with: 1000

      click_on 'Update Station'

      expect(page).to have_button('Update Station')
      expect(page).to have_content('This station has NOT been updated.')
      expect(page).to_not have_content('This station has been updated.')
    end
  end
end
