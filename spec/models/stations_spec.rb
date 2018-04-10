require 'rails_helper'

describe Station do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:dock_count)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:installation_date)}
    it {should validate_presence_of(:latitude)}
    it {should validate_presence_of(:longitude)}
  end

  describe '#generate_slug' do
    it 'should parameterize the name' do
      station = create(:station)

      expect(station.slug).to eq(station.name.parameterize)
    end
  end

  describe '#to_param' do
    it 'uses slug as param instead of id' do
      station = create(:station)

      expect(station.to_param).to eq(station.slug)
    end
  end
end
