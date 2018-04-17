require 'rails_helper'

describe 'admin' do
  describe 'edits account info' do
    it 'has updated account info' do
      admin = create(:admin, username: 'Dougy', password: 'password', email: 'email@realmail.com')

      visit root_path

      click_on "Login"

      fill_in 'username', with: admin.username
      fill_in 'password', with: admin.password
      click_on "Login"

      click_on "Logged in as Admin User: #{admin.username}"
      
      click_on "Edit Account"

      fill_in 'user[username]', with: 'Larry'
      fill_in 'user[email]', with: 'realmail@larry.com'
      fill_in 'user[password]', with: 'wordpass'

      click_on 'Update User'

      expect(page).to have_content('This user has been updated')
    end
  end
end
