FactoryBot.define do
  factory :cart_item do
    association :cart, factory: :cart
    product
    quantity { 1 }
  end
end
