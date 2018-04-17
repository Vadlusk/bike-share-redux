require 'date'

FactoryBot.define do
  factory :accessory do
    sequence(:title) { |n| "Title#{n}" }
    sequence(:description) { ['Can to make your back tire sound like a motorcycle', 'Bell that rings like the heavens itself', 'Headlight brighter than a thousand supernovas'].sample }
    price { rand(0.00..1000.00) }
    image_url { "http://icons.iconarchive.com/icons/guillendesign/variations-3/256/Default-Icon-icon.png" }
    status 0
  end
end
