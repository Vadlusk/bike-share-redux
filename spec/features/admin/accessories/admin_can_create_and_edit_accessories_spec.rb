require 'rails_helper'

describe 'admin' do
  describe 'can edit an accessory' do
    it 'clicks edit button' do
      create(:accessory, status: 0)
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_bike_shop_path

      find(:xpath, ".//a[i[contains(@class, 'far fa-edit')]]").click

      fill_in 'accessory[title]', with: 'Hairmet'
      fill_in 'accessory[description]', with: 'Protects your hairstyle'
      fill_in 'accessory[price]', with: 3.99
      select 'retired', from: 'accessory[status]'

      click_on 'Update Accessory'

      expect(current_path).to eq(admin_bike_shop_path)

      expect(page).to have_content('Hairmet')
      expect(page).to have_content('Protects your hairstyle')
      expect(page).to have_content('retired')
      expect(page).to_not have_content('active')
      expect(page).to have_content("Accessory has been updated.")
    end
  end
  describe 'can create an accessory' do
    it 'creates new accessory' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_accessory_path

      fill_in 'accessory[title]', with: 'Hairmet'
      fill_in 'accessory[description]', with: 'Protects your hairstyle'
      fill_in 'accessory[price]', with: 3.99
      select 'retired', from: 'accessory[status]'

      click_on 'Create Accessory'

      expect(current_path).to eq(admin_bike_shop_path)

      expect(page).to have_content('Hairmet')
      expect(page).to have_content('Protects your hairstyle')
      expect(page).to have_content('retired')
    end
    it 'must have title' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_accessory_path

      fill_in 'accessory[title]', with: ''
      fill_in 'accessory[description]', with: 'Protects your hairstyle'
      fill_in 'accessory[price]', with: 3.99
      select 'retired', from: 'accessory[status]'

      click_on 'Create Accessory'

      expect(page).to have_content('Accessory has NOT been created, please make sure you fill in all of the form')
    end
    it 'must have description' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_accessory_path

      fill_in 'accessory[title]', with: 'Hairmet'
      fill_in 'accessory[description]', with: ''
      fill_in 'accessory[price]', with: 3.99
      select 'retired', from: 'accessory[status]'

      click_on 'Create Accessory'

      expect(page).to have_content('Accessory has NOT been created, please make sure you fill in all of the form')
    end
    it 'must have valid price' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_accessory_path

      fill_in 'accessory[title]', with: 'Hairmet'
      fill_in 'accessory[description]', with: 'Protects your hairstyle'
      fill_in 'accessory[price]', with: ''
      select 'retired', from: 'accessory[status]'

      click_on 'Create Accessory'

      expect(page).to have_content('Accessory has NOT been created, please make sure you fill in all of the form')
    end
  end
end
