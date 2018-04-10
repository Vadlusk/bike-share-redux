require 'rails_helper'

describe 'Visitor' do
  describe 'as a registered user on root path' do
    it 'can click login link and login to account with required credentials' do
      visit '/'
      click_on "Login"

      expect(current_path).to eq("/login")

      user = create(:user)

      fill_in 'username', with: user.username
      fill_in 'password', with: user.password
      click_on "Login"

      expect(current_path).to eq("/dashboard")

      within(".navbar") do
        expect(page).to have_content("Logged in as #{username}")
        expect(page).to have_content("Logout")
      end

      expect(page).to_not have_content("Login")
    end
  end
end
