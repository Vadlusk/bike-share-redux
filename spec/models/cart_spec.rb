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
  end
  context 'Class methods' do
    context '::total_price' do
      it 'calculates the total price' do
        accessory_1, accessory_2, accessory_3 = create_list(:accessory, 3)
        cart = Cart.new(nil)
        cart.add_accessory(accessory_1)
        cart.add_accessory(accessory_2)
        cart.add_accessory(accessory_3)

        expect(cart.contents.total_price).to eq(accessory_1.price + accessory_2.price + accessory_3.price)
      end
    end
  end
end
