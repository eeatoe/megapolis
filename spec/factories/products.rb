FactoryBot.define do
  factory :product do
    name { "Sample Product #{Faker::Lorem.word}" }
    description { Faker::Lorem.sentence(word_count: 30) }
    base_price { Faker::Commerce.price(range: 10..1000.0) }
    main_material { Faker::Lorem.word }
    filling_material { Faker::Lorem.word }
  
    trait "with_category" do
      association :category
    end

    trait "with_brand" do
      association :brand, factory: :brand
    end

    # Загрузка изображений через ActiveStorage
    # after(:build) do |product|
    #   product.images.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'image.jpg')), filename: 'image.jpg', content_type: 'image/jpg')
    # end
  end
end
