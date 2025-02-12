FactoryBot.define do
  factory :variant do
    association :product
    price { Faker::Commerce.price(range: 10.0..100.0) }
    stock_status { %w[in_stock out_of_stock pre_order].sample }
    stock_quantity { Faker::Number.between(from: 0, to: 100) }
    color { Faker::Commerce.color }
    size { %w[S M L XL XXL].sample }
    weight { Faker::Number.decimal(l_digits: 1, r_digits: 2) }

    trait :in_stock do
      stock_status { "in_stock" }
      stock_quantity { Faker::Number.between(from: 1, to: 100) }
    end

    trait :out_of_stock do
      stock_status { "out_of_stock" }
      stock_quantity { 0 }
    end

    trait :pre_order do
      stock_status { "pre_order" }
      stock_quantity { Faker::Number.between(from: 1, to: 100) }
    end
  end
end
