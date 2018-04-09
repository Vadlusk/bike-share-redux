require 'rails_helper'

describe 'Visitor' do
  describe 'visits the root path' do
    it 'see a login link' do
      visit '/'

      within("#link1") do
        expect(page).to have_content("Login")
      end

      click_on "Login"

      expect(current_path).to eq("/login")
    end
  end

  describe 'can click create a new account link and complete the form' do
    it 'and it creates a new account' do
      username = "username"
      password = "password"
      email = "email@email.com"

      visit '/login'
      click_on 'Create Account'

      expect(current_path).to eq(register_path)

      fill_in 'user[username]', with: username
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password
      fill_in 'user[email]', with: email
      click_on "Create Account"

      expect(current_path).to eq("/dashboard")

      within(".nav") do
        expect(page).to have_content("Logged in as #{username}")
      end

      expect(page).to have_css(".logout-button")
      expect(page).to_not have_css(".login-button")
    end
  end
end
