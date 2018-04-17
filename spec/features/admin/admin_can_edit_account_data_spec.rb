require 'rails_helper'

describe 'admin' do
  describe 'edits account info' do
    it 'has updated account info' do
      admin = create(:admin, username: 'Dougy', password: 'password', email: 'email@realmail.com', role: 1)

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
    it 'cannot update anothers info' do
      admin1 = create(:user, id: 1, username: 'Bobby', password: 'password', email: 'bob@email.com', role: 1)
      user2 = create(:user, id: 2, username: 'Dougy', password: 'password', email: 'doug@email.com', role: 1)

      visit root_path

      click_on "Login"

      fill_in 'username', with: admin1.username
      fill_in 'password', with: admin1.password
      click_on "Login"

      visit '/users/2/edit'

      fill_in 'user[username]', with: 'Larry'
      fill_in 'user[email]', with: 'realmail@larry.com'
      fill_in 'user[password]', with: 'wordpass'

      click_on 'Update User'

      expect(user2.username).to_not eq('Larry')
      expect(user2.password).to_not eq('wordpass')
      expect(user2.email).to_not eq('realmail@larry.com')
    end
  end
end
