require 'rails_helper'

describe Accessory do
  context 'Field validations' do
    context ''
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_uniqueness_of(:title) }
    it { should validate_numericality_of(:price) }
  end
  context 'instance methods' do
    context '#active?' do
      it 'returns true if item is active' do
        accessory = Accessory.create(title: 'Retired Item',
                                     description: 'An item which can no longer be purchased',
                                     price: 50.50,
                                     image_url: "http://www.iwantthatsign.com/WebRoot/BT2/Shops/BT4029/4B92/6F4B/DA52/7B6F/97F3/0A0A/33E8/E557/retired-and-lovin-it-2011.jpg",
                                     status: 0)

        expect(accessory.active?).to eq(true)
      end
      it 'returns false if item is retired' do
        accessory = Accessory.create(title: 'Retired Item',
                                     description: 'An item which can no longer be purchased',
                                     price: 50.50,
                                     image_url: "http://www.iwantthatsign.com/WebRoot/BT2/Shops/BT4029/4B92/6F4B/DA52/7B6F/97F3/0A0A/33E8/E557/retired-and-lovin-it-2011.jpg",
                                     status: 1)

        expect(accessory.active?).to eq(false)
      end
    end
  end
end
