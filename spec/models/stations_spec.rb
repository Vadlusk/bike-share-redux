require 'rails_helper'

describe Station do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:dock_count)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:installation_date)}
    it {should validate_presence_of(:lat)}
    it {should validate_presence_of(:long)}
    it { should validate_inclusion_of(:lat).in_range(-90..90) }
    it { should validate_inclusion_of(:long).in_range(-180..180) }
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

  describe '#built' do
    it 'changes date formatting' do
      station = create(:station)

      expect(station.built).to eq(station.installation_date.strftime("%B %d, %Y"))
    end
  end
end
