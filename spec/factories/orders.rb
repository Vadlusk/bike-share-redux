FactoryBot.define do
  factory :order do
    sequence(:status) { rand(0..3) }
    user
  end
end
