FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Quote.yoda }
    price { Faker::Number.number(digits: 3) }
  end
end
