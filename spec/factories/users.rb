FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { "Password123" }
    password_confirmation { "Password123" }
    role { "customer" }

    trait :admin do
      role { "admin" }
    end

    # Вместо автоматического создания зависимостей, делаем их
    # опциональными, чтобы не допустить проблему каскадных фабрик
    trait :with_cart do
      after(:create) { |user| create(:cart, user: user) }
    end

    trait :with_orders do
      after(:create) { |user| create_list(:order, 3, user: user) }
    end
  end
end
