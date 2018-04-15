require 'rails_helper'

describe Order do
  context 'field validations' do
    context 'valid attributes' do
      it 'is valid with all attributes' do
        user  = create(:user)
        order = Order.create(user_id: user.id)

        expect(user).to be_valid
      end
    end
    context 'invalid attributes' do
      it 'is invalid without a user' do
        order = Order.create()

        expect(order).to_not be_valid
      end
    end
  end
  context 'instance methods' do
    context '#total_price' do
      it 'calculates the price for an order' do
        order = create(:order)
        accessory_1       = create(:accessory, price: 5)
        order_accessory_1 = accessory_1.order_accessories.create(quantity: 3, order_id: order.id)
        accessory_2       = create(:accessory, price: 30)
        order_accessory_2 = accessory_2.order_accessories.create(quantity: 1, order_id: order.id)
        accessory_3       = create(:accessory, price: 10)
        order_accessory_3 = accessory_3.order_accessories.create(quantity: 20, order_id: order.id)

        expect(order.total_price).to eq(245)
      end
    end
  end
end
