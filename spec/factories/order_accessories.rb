FactoryBot.define do
  factory :order_accessory do
    sequence(:quantity) { rand(1..9)}
    order
    accessory
  end
end
