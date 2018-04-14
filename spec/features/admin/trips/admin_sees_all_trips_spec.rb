require 'rails_helper'

describe 'Admin' do
  context 'visits the trips index' do
    scenario 'and it has links to edit and delete trips' do
      admin = create(:admin)
      trip  = create(:trip)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit trips_path

      expect(page).to have_button('Delete')
      expect(page).to have_button('Edit')
    end
  end
end
