FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user-#{n}" }
    password 'password'
    sequence(:email)    { |n| "email#{n}@email.com" }
  end
end
