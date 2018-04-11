require 'rails_helper'

describe Cart do
  context 'Instance methods' do
    context '#add_accessory' do
      it 'adds an accessory to contents' do
        cart = Cart.new({'1' => 1, '2' => 1})
        cart.add_accessory(1)
        cart.add_accessory(2)

        expect(cart.contents).to eq({'1' => 2, '2' => 2})
      end
    end
    context '#total_item_count' do
      it 'calculates the total accessories in contents' do
        cart = Cart.new({'1' => 1, '2' => 1})

        expect(cart.total_item_count).to eq(2)
      end
    end
    context '#accessory_array' do
      it 'makes an active record collection of accessory objects' do
        accessory_1 = create(:accessory)
        accessory_2 = create(:accessory)
        cart = Cart.new({'1' => 1, '2' => 1})
        cart.add_accessory(accessory_1.id)
        cart.add_accessory(accessory_2.id)

        expect(cart.accessory_array.length).to eq(2)
        expect(cart.accessory_array.first).to be_an_instance_of(Accessory)
      end
    end
  end
end
