require 'rails_helper'

describe 'admin' do
  describe 'visits the stations dashboard' do
    it 'sees the total count of stations' do
      create_list(:station, 30)

      visit '/stations-dashboard'

      expect(page).to have_content('There are 30 bike share stations')
    end

    it 'sees the average bikes available per station' do
      create_list(:station, 30)

      visit '/stations-dashboard'

      expect(page).to have_content("Average bikes per station: #{Station.average(:dock_count).round(2)}")
    end

    it 'sees the most bikes availabe at a station' do
      create_list(:station, 30)

      visit '/stations-dashboard'

      expect(page).to have_content("The most bikes available at any station: #{Station.maximum(:dock_count)}")
    end

    it 'sees the station where the most bikes are available' do
      create_list(:station, 30)
      create(:station, name: 'Manystationbikemany', dock_count: 1000)

      visit '/stations-dashboard'

      expect(page).to have_content('The station(s) with the most bikes available:')
      expect(page).to have_content('Manystationbikemany (1000)')
    end

    it 'sees the stations where the most bikes are available' do
      create_list(:station, 30)
      create(:station, name: 'Beep Blorp', dock_count: 1000)
      create(:station, name: 'Doopy Doop', dock_count: 1000)

      visit '/stations-dashboard'

      expect(page).to have_content('The station(s) with the most bikes available:')
      expect(page).to have_content('Beep Blorp (1000)')
      expect(page).to have_content('Doopy Doop (1000)')
    end

    it 'sees the fewest bikes availabe at a station' do
      create_list(:station, 30)

      visit '/stations-dashboard'

      expect(page).to have_content("The fewest bikes available at any station: #{Station.minimum(:dock_count)}")
    end

    it 'sees the station where the fewest bikes are available' do
      create_list(:station, 30)
      create(:station, name: 'Fewstationbikefew', dock_count: 0)

      visit '/stations-dashboard'

      expect(page).to have_content('The station(s) with the fewest bikes available:')
      expect(page).to have_content('Fewstationbikefew (0)')
    end

    it 'sees the stations where the fewest bikes are available' do
      create_list(:station, 30)
      create(:station, name: 'Not much', dock_count: 0)
      create(:station, name: 'Many none', dock_count: 0)

      visit '/stations-dashboard'

      expect(page).to have_content('The station(s) with the fewest bikes available:')
      expect(page).to have_content('Not much (0)')
      expect(page).to have_content('Many none (0)')
    end

    it 'sees the newest station by installation_date' do
      create_list(:station, 30)
      create(:station, name: 'Brand Spanking New', installation_date: '2020-01-30')

      visit '/stations-dashboard'


      expect(page).to have_content('The newest staton is Brand Spanking New - Installed: January 30, 2020')
    end

    it 'sees the oldest station by installation_date' do
      create_list(:station, 30)
      create(:station, name: 'Dirty Old Station', installation_date: '2001-01-30')

      visit '/stations-dashboard'

      expect(page).to have_content('The oldest staton is Dirty Old Station - Installed: January 30, 2001')
    end
  end
end
