require 'rails_helper'

describe 'User' do
  describe 'as a registered default user' do
    it 'sees profile information on dashboard page' do
      user = create(:user)

      visit dashboard_path

      expect(page).to have_content(user.username)
      expect(page).to have_content(user.email)
    end
    it 'sees orders' do
      user   = create(:user)
      orders = create_list(:order, 10)

      visit dashboard_path

      orders.each do |order|
        expect(page).to have_content()
      end
    end
  end
end
