require 'rails_helper'
# require './models/cart'

describe 'Visitor' do
  context 'a visitor goes to the cart page' do
    it 'displays all added accessories' do
      # accessories = create_list(:accessory, 5)

      accessory1 = Accessory.create!(title: "help", description: "Bad", price: 10, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
      accessory2 = Accessory.create!(title: "help", description: "Bad", price: 10, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
      accessory3 = Accessory.create!(title: "help", description: "Bad", price: 10, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
      accessory4 = Accessory.create!(title: "help", description: "Bad", price: 10, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
      accessory5 = Accessory.create!(title: "help", description: "Bad", price: 10, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)

      accessories = [accessory1, accessory2, accessory3, accessory4, accessory5]
      visit bike_shop_path

      within('form:nth-of-type(1)') do
        click_button("Add to Cart")
      end
      within('form:nth-of-type(2)') do
        click_button("Add to Cart")
      end
      within('form:nth-of-type(3)') do
        click_button("Add to Cart")
      end
      within('form:nth-of-type(4)') do
        click_button("Add to Cart")
      end
      within('form:nth-of-type(5)') do
        click_button("Add to Cart")
      end

      visit cart_path

      accessories.each do |accessory|
        expect(page).to have_content(accessory.title)
        expect(page).to have_content(accessory.price)
        expect(page).to have_content(accessory.subtotal(1))
        expect(page).to have_content("1")
      end
      expect(page).to have_content("Total: $50")
    end
    it 'creates account and cart persists' do
      accessory1 = Accessory.create!(title: "help", description: "Bad", price: 10, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
      accessory2 = Accessory.create!(title: "help", description: "Bad", price: 10, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
      accessory3 = Accessory.create!(title: "help", description: "Bad", price: 10, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
      accessory4 = Accessory.create!(title: "help", description: "Bad", price: 10, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)
      accessory5 = Accessory.create!(title: "help", description: "Bad", price: 10, image_url: "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png", status: 0)

      accessories = [accessory1, accessory2, accessory3, accessory4, accessory5]

      visit bike_shop_path

      within('form:nth-of-type(1)') do
        click_button("Add to Cart")
      end
      within('form:nth-of-type(2)') do
        click_button("Add to Cart")
      end
      within('form:nth-of-type(3)') do
        click_button("Add to Cart")
      end
      within('form:nth-of-type(4)') do
        click_button("Add to Cart")
      end
      within('form:nth-of-type(5)') do
        click_button("Add to Cart")
      end

      visit register_path


      fill_in 'user[username]', with: "Adam"
      fill_in 'user[email]', with: "testing"
      fill_in 'user[password]', with: "password"
      fill_in 'user[password_confirmation]', with: "password"

      visit cart_path

      accessories.each do |accessory|
        expect(page).to have_content(accessory.title)
        expect(page).to have_content(accessory.price)
        expect(page).to have_content(accessory.subtotal(1))
        expect(page).to have_content("1")
      end
      expect(page).to have_content("Total: $50")
    end
  end

end
