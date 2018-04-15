require 'rails_helper'

describe 'Admin' do
  context 'sees dashboard' do
    it 'displays all orders' do
      admin  = create(:admin)
      orders = create_list(:order, 10)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_dashboard_path

      orders.each do |order|
        expect(page).to have_content(order.id)
        expect(page).to have_content(order.user.username)
        expect(page).to have_content(order.created_at)
        expect(page).to have_content(order.status)
      end
    end
  end
end
