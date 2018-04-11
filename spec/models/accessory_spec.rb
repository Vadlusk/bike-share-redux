require 'rails_helper'

describe Accessory do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe '#active?' do
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
  context 'Class methods' do
    context '::total_price' do
      it 'calculates the total price' do
        accessory_1, accessory_2, accessory_3 = create_list(:accessory, 3)

        expect(Accessory.total_price).to eq(accessory_1.price + accessory_2.price + accessory_3.price)
      end
    end
  end
end
