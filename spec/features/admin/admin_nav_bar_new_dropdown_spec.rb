require 'rails_helper'

describe 'admin' do
  describe 'interacts with new dropdown' do
    it 'can get to create new accessory' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      click_on 'New'
      click_on 'Accessory'

      expect(current_path).to eq(new_admin_accessory_path)
    end
    it 'can get to create new condition' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      click_on 'New'
      click_on 'Condition'

      expect(current_path).to eq(new_admin_condition_path)
    end
    it 'can get to create new station' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      click_on 'New'
      click_on 'Station'

      expect(current_path).to eq(new_admin_station_path)
    end
    it 'can get to create new trip' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      click_on 'New'
      click_on 'Trip'

      expect(current_path).to eq(new_admin_trip_path)
    end
  end
end
