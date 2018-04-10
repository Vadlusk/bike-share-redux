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

      within(".navbar") do
        expect(page).to have_content("Logged in as #{username}")
        expect(page).to have_content("Logout")
      end

      expect(page).to_not have_content("Login")
    end

    it 'but cannot create an account if chosen username already exists in database' do
      user = create(:user)
      password = "password"
      email = "email@email.com"

      visit '/login'
      click_on 'Create Account'

      expect(current_path).to eq(register_path)

      fill_in 'user[username]', with: user.username
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password
      fill_in 'user[email]', with: email
      click_on "Create Account"

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Failed to create new account. Please try again.")
    end

    it 'but cannot create an account if provided email already exists in database' do
      user = create(:user)
      username = "user"
      password = "password"

      visit '/login'
      click_on 'Create Account'

      expect(current_path).to eq(register_path)

      fill_in 'user[username]', with: username
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password
      fill_in 'user[email]', with: user.email
      click_on "Create Account"

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Failed to create new account. Please try again.")
    end

    it 'but cannot create an account if password and password confirmation fields do not match' do
      username = "user"
      password = "password"
      password_2 = "password2"
      email = "email@email.com"

      visit '/login'
      click_on 'Create Account'

      expect(current_path).to eq(register_path)

      fill_in 'user[username]', with: username
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password_2
      fill_in 'user[email]', with: email
      click_on "Create Account"

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Failed to create new account. Please try again.")
    end
  end
end
