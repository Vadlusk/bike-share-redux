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
  context 'class methods' do
    context '#status_total' do
      it 'gets the total orders for a given status' do
        create_list(:order, 8, status: 'paid')
        create_list(:order, 5, status: 'ordered')
        create_list(:order, 2, status: 'cancelled')
        create_list(:order, 7, status: 'completed')

        expect(Order.status_total('paid')).to eq(8)
        expect(Order.status_total('ordered')).to eq(5)
        expect(Order.status_total('cancelled')).to eq(2)
        expect(Order.status_total('completed')).to eq(7)
      end
    end
  end
end
