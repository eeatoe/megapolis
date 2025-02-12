FactoryBot.define do
  factory :category do
    name { "Category #{Faker::Lorem.word}" }
    slug { name.parameterize }

    trait :with_parent do
      association :parent, factory: :category
    end

    trait :with_children do
      after(:create) do |category|
        create_list(:category, 3, parent: category)
      end
    end

    trait :with_products do
      after(:create) do |category|
        create_list(:category, 3, parent: category)
      end
    end
  end
end
