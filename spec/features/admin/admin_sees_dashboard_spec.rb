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
    it 'has totals of each status' do
      admin  = create(:admin)
      create_list(:order, 8, status: 'paid')
      create_list(:order, 5, status: 'ordered')
      create_list(:order, 2, status: 'cancelled')
      create_list(:order, 7, status: 'completed')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_dashboard_path

      expect(page).to have_content(': 8')
      expect(page).to have_content(': 5')
      expect(page).to have_content(': 2')
      expect(page).to have_content(': 7')
    end
    it 'has links to go to each order show' do
      admin  = create(:admin)
      orders = create_list(:order, 8)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_dashboard_path

      orders.each do |order|
        expect(page).to have_link(order.id)
      end
    end
    it 'can sort orders by status' do
      admin     = create(:admin)
      ordered   = create(:order, status: 'ordered')
      completed = create(:order, status: 'completed')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_dashboard_path
      click_on 'Ordered'

      expect(page).to have_content(ordered.user.username)
      expect(page).to_not have_content(completed.user.username)

      click_on 'Completed'

      expect(page).to have_content(completed.user.username)
      expect(page).to_not have_content(ordered.user.username)
    end
    it 'can cancel orders that are ordered' do
      admin   = create(:admin)
      ordered = create(:order, status: 'ordered')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_dashboard_path
      click_on 'Cancel'

      expect(ordered.status).to eq('cancelled')
    end
    it 'can cancel orders that are paid' do
      admin   = create(:admin)
      paid    = create(:order, status: 'paid')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_dashboard_path
      click_on 'Cancel'

      expect(paid.status).to eq('cancelled')
    end
    it 'can mark as paid ordered orders' do
      admin     = create(:admin)
      ordered   = create(:order, status: 'ordered')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_dashboard_path
      click_on 'Mark as Paid'

      expect(ordered.status).to eq('paid')
    end
    it 'can mark as completed orders that are paid' do
      admin     = create(:admin)
      paid    = create(:order, status: 'paid')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_dashboard_path
      click_on 'Mark as Completed'

      expect(paid.status).to eq('completed')
    end
  end
end
