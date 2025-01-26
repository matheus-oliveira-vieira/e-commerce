FactoryBot.define do
  factory :user do
    name { "João Silva" }
    cpf { "12345678900" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "senha_segura" }
    password_confirmation { "senha_segura" }
  end
end
