require 'rails_helper'

describe 'admin' do
  describe 'sees and clicks link to bike shop from admin dashboard' do
    it 'has the url /admin/bike-shop' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      click_on 'All Accessories'

      expect(current_path).to eq('/admin/bike-shop')
    end
    it 'sees a table with all accessories' do
      create_list(:accessory, 20)
      create(:accessory, title: 'Some junk', status: 1)
      create(:accessory, title: 'Other junk', status: 1)
      create(:accessory, title: 'Mostly junk', status: 1)
      create(:accessory, title: 'Definitely junk', status: 1)
      create(:accessory, title: 'Not quite junk', status: 1)
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_bike_shop_path

      expect(page).to have_content('Some junk')
      expect(page).to have_content('Other junk')
      expect(page).to have_content('Mostly junk')
      expect(page).to have_content('Definitely junk')
      expect(page).to have_content('Not quite junk')
    end
    it 'can retire an item from index' do
      create(:accessory, title: 'Some junk', status: 0)
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_bike_shop_path

      click_on 'Retire'

      expect(page).to have_content('retired')
      expect(page).to_not have_content('active')
    end
    it 'can activate an item from index' do
      create(:accessory, title: 'Some junk', status: 1)
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_bike_shop_path

      click_on 'Activate'

      expect(page).to have_content('active')
      expect(page).to_not have_content('retired')
    end
  end
end
