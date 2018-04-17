require 'rails_helper'

describe 'Admin' do
  context 'visits the trips index' do
    scenario 'and it has links to edit and delete trips' do
      admin = create(:admin)
      trip  = create(:trip)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit trips_path

      within(".table-buttons") do
        expect(page).to have_xpath(".//a[i[contains(@class, 'far fa-trash-alt')]]")
        expect(page).to have_xpath(".//a[i[contains(@class, 'far fa-edit')]]")
      end
    end
  end
end
