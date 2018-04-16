require 'rails_helper'

describe 'admin' do
  describe 'sees and clicks link to bike shop from admin dashboard' do
    it 'has the url /admin/bike-shop' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      click_on 'Bike Shop'

      expect(current_path).to eq('/admin/bike-shop')
    end
    it 'sees a table with all accessories' do

    end
  end
end
