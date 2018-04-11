require 'rails_helper'

describe Cart do
  describe '#add_accessory' do
    it 'adds an accessory to contents' do
      cart = Cart.new({'1' => 1, '2' => 1})
      cart.add_accessory(1)
      cart.add_accessory(2)

      expect(cart.contents).to eq({'1' => 2, '2' => 2})
    end
  end
  describe '#total_item_count' do
    it 'calculates the total accessories in contents' do
      cart = Cart.new({'1' => 1, '2' => 1})

      expect(cart.total_item_count).to eq(2)
    end
  end
end
