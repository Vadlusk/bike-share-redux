require 'rails_helper'

describe 'Visitor' do
  context 'as a registered admin user' do
    it 'can login to account with required credentials' do
      visit root_path
      click_on "Login"

      expect(current_path).to eq(login_path)

      admin = create(:admin)

      fill_in 'username', with: admin.username
      fill_in 'password', with: admin.password
      click_on "Login"

      expect(current_path).to eq(admin_dashboard_path)

      within(".navbar") do
        expect(page).to have_content("Logged in as Admin User: #{admin.username}")
        expect(page).to have_content("Logout")
      end

      expect(page).to_not have_content("Login")
    end
  end

  context 'as a registered default user' do
    it 'cannot access admin dashboard' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end
end
