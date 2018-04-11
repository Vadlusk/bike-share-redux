require 'rails_helper'

describe 'Visitor' do
  context 'as a registered admin user' do
    it 'can delete a condition' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      condition_1, condition_2, condition_3 = create_list(:condition, 3)

      visit conditions_path

      within(".condition-#{condition_1.id}") do
        find(:xpath, ".//a[i[contains(@class, 'far fa-trash-alt')]]").click
      end

      expect(current_path).to eq(conditions_path)

      expect(page).to_not have_content(".condition-#{condition_1.id}")
    end
  end
end
