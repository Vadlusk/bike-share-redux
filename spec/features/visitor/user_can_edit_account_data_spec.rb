require 'rails_helper'

describe 'user' do
  describe 'edits account info' do
    it 'has updated account info' do
      user = create(:user, username: 'Bobby', password: 'password', email: 'email@realmail.com')

      visit root_path

      click_on "Login"

      fill_in 'username', with: user.username
      fill_in 'password', with: user.password
      click_on "Login"

      click_on "Logged in as #{user.username}"

      click_on "Edit Account"

      fill_in 'user[username]', with: 'Larry'
      fill_in 'user[email]', with: 'realmail@larry.com'
      fill_in 'user[password]', with: 'wordpass'
      fill_in 'user[password_confirmation]', with: 'wordpass'

      click_on 'Update Account Information'

      expect(page).to have_content('This user has been updated')
    end
    it 'cannot update anothers info' do
      user1 = create(:user, id: 1, username: 'Bobby', password: 'password', email: 'bob@email.com')
      user2 = create(:user, id: 2, username: 'Dougy', password: 'password', email: 'doug@email.com')

      visit root_path

      click_on "Login"

      fill_in 'username', with: user1.username
      fill_in 'password', with: user1.password
      click_on "Login"

      visit '/users/2/edit'

      fill_in 'user[username]', with: 'Larry'
      fill_in 'user[email]', with: 'realmail@larry.com'
      fill_in 'user[password]', with: 'wordpass'
      fill_in 'user[password_confirmation]', with: 'wordpass'

      click_on 'Update Account Information'

      expect(user2.username).to_not eq('Larry')
      expect(user2.password).to_not eq('wordpass')
      expect(user2.email).to_not eq('realmail@larry.com')
    end
  end
end
