FactoryBot.define do
  factory :admin, class: User do
    username 'admin'
    password 'password'
    sequence(:email) { |n| "admin#{n}@email.com" }
    role 1
  end
end
