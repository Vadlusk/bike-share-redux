require 'rails_helper'

describe 'admin' do
  describe 'can edit an accessory' do
    it 'can click a button to deactivate an accessory' do
      accessory = create(:accessory, status: 0)
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_bike_shop_path

      click_on 'Deactivate'

      expect(accessory.status).to eq(1)
    end
  end
end
