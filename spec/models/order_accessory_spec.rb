require 'rails_helper'

describe OrderAccessory, type: :model do
  context 'field validations' do
    context 'valid attributes' do
      it 'is valid with all attributes' do
        order           = create(:order)
        accessory       = create(:accessory)
        order_accessory = OrderAccessory.create!(order_id: order.id, accessory_id: accessory.id, quantity: 1)

        expect(order_accessory).to be_valid
      end
    end
    context 'invalid attributes' do
      it 'is invalid without an order' do
        accessory       = create(:accessory)
        order_accessory = OrderAccessory.create(order_id: '', accessory_id: accessory.id, quantity: 1)

        expect(order_accessory).to_not be_valid
      end
      it 'is invalid without an accessory' do
        order           = create(:order)
        order_accessory = OrderAccessory.create(order_id: order.id, accessory_id: '', quantity: 1)

        expect(order_accessory).to_not be_valid
      end
      it 'is invalid without a quantity' do
        order           = create(:order)
        accessory       = create(:accessory)
        order_accessory = OrderAccessory.create(order_id: order.id, accessory_id: accessory.id, quantity: '')

        expect(order_accessory).to_not be_valid
      end
    end
  end
  context 'instance methods' do
    context '#subtotal' do
      it 'calculates the cost of each item on an order' do
        accessory       = create(:accessory, price: 25)
        order_accessory = create(:order_accessory, quantity: 10, accessory_id: accessory.id)

        expect(order_accessory.subtotal).to eq(250)
      end
    end
  end
  context 'relationships' do
    it 'belongs to an order' do
      order_accessory = create(:order_accessory)

      expect(order_accessory).to respond_to(:order)
    end
    it 'belongs to an accessory' do
      order_accessory = create(:order_accessory)

      expect(order_accessory).to respond_to(:accessory)
    end
  end
end
