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
end
