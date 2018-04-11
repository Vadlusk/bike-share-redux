require 'rails_helper'

describe 'Visitor' do
  describe 'as a registered default user' do
    it 'can login to account with required credentials' do
      visit root_path
      click_on "Login"

      expect(current_path).to eq(login_path)

      user = create(:user)

      fill_in 'username', with: user.username
      fill_in 'password', with: user.password
      click_on "Login"

      expect(current_path).to eq(dashboard_path)

      within(".navbar") do
        expect(page).to have_content("Logged in as #{user.username}")
        expect(page).to have_content("Logout")
      end

      expect(page).to_not have_content("Login")
    end

    it 'cannot login to account with incorrect credentials' do
      visit root_path
      click_on "Login"

      expect(current_path).to eq(login_path)

      user = create(:user)

      fill_in 'username', with: user.username
      fill_in 'password', with: "bad_password"
      click_on "Login"

      expect(current_path).to eq(login_path)

      expect(page).to have_content("Invalid username and/or password")
    end
  end
end
