require 'rails_helper'

describe 'User' do
  context 'as an authenticated default user' do
    it 'can logout of account' do
      user = create(:user)

      visit root_path

      click_on "Login"

      fill_in 'username', with: user.username
      fill_in 'password', with: user.password
      click_on "Login"

      visit root_path

      within("#link1") do
        click_on "Logout"
      end

      within("#link1") do
        expect(page).to have_content("Login")
        expect(page).to_not have_content("Logout")
      end
    end
  end

  describe 'as an authenticated admin' do
    it 'can logout of account' do
      admin = create(:admin)

      visit root_path

      click_on "Login"

      fill_in 'username', with: admin.username
      fill_in 'password', with: admin.password
      click_on "Login"

      visit root_path

      within("#link1") do
        click_on "Logout"
      end

      within("#link1") do
        expect(page).to have_content("Login")
        expect(page).to_not have_content("Logout")
      end
    end
  end
end
