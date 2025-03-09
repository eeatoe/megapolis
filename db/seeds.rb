# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# <------------------------->
# Добовление тестовых Брендов
# <------------------------->
BRANDS = [
  "Calvin Clein",
  "New Balance",
  "Adidas",
  "Prada",
  "Gucci",
  "Nike"
]

BRANDS.each do |brand_name|
  brand = Brand.find_or_create_by!(name: brand_name)

  # Формируем путь к изображению
  logo_filename = "#{brand_name.downcase.gsub(' ', '-')}.png}"
  logo_path = Rails.root.join("app/assets/images/#{logo_filename}")

  if File.exist?(logo_path) && !brand.logo.attached?
    brand.logo.attach(io: File.open(logo_path), filename: logo_filename)
  end
end


# <-------------------------->
# Добовление базовых Категорий
# <-------------------------->

# Создаём основные категории
outerwear = Category.find_or_create_by!(name: "Верхняя одежда")
trousers = Category.find_or_create_by!(name: "Брюки")
accessories = Category.find_or_create_by!(name: "Аксессуары")

# Создаём подкатегории
Category.find_or_create_by!(name: "Футболки", parent: outerwear)
Category.find_or_create_by!(name: "Толстовки", parent: outerwear)
Category.find_or_create_by!(name: "Куртки", parent: outerwear)

Category.find_or_create_by!(name: "Джинсы", parent: trousers)
Category.find_or_create_by!(name: "Спортивные брюки", parent: trousers)
Category.find_or_create_by!(name: "Джогеры", parent: trousers)

Category.find_or_create_by!(name: "Сумки", parent: accessories)
Category.find_or_create_by!(name: "Ремни", parent: accessories)
Category.find_or_create_by!(name: "Очки", parent: accessories)

# <------------------------------->
# Добовление тестовых пользователей
# <------------------------------->

first_user = User.find_by(email: "eeeatoe@example.com")
unless first_user
  first_user = User.create!(
    name: "Sergey", 
    email: "eeeatoe@example.com", 
    password: "123A3!hrT", 
    password_confirmation: "123A3!hrT"
  )
end

second_user = User.find_by(email: "hexatoe@example.com")
unless second_user
  second_user = User.create!(
    name: "Аня", 
    email: "hexatoe@example.com", 
    password: "123A3!hrT", 
    password_confirmation: "123A3!hrT"
  )
end

# <--------------------------->
# Добовление тестовых Продуктов
# <--------------------------->

first_product = Product.find_or_create_by!(
  name: "Мужская спортивная куртка с утеплителем для холодной погоды",
  description: "Эта куртка обеспечит комфорт и защиту в холодные дни. Ветрозащитная ткань, удобный капюшон и стильный крой делают её идеальным выбором для активного отдыха.",
  base_price: 5990.00,
  main_material: "Полиэстер",
  filling_material: "Синтепон",
  category: Category.find_by(name: "Куртки"),
  brand: Brand.find_by(name: "Nike")
)

ProductRating.find_or_create_by!(
  product: first_product,
  user: first_user,
  value: 4
)

ProductRating.find_or_create_by!(
  product: first_product,
  user: second_user,
  value: 3
)

# <--------------------------->

first_product = Product.find_or_create_by!(
  name: "Мужская спортивная куртка с легким дышащим материалом для разных сезонов",
  description: "Эта куртка идеально подойдет для меняющейся осенней и весенней погоды. Она надежно защищает от ветра и дождя, при этом сохраняет комфорт и удобство.",
  base_price: 7990.00,
  main_material: "Полиэстер",
  filling_material: "Синтепон",
  category: Category.find_by(name: "Куртки"),
  brand: Brand.find_by(name: "Adidas")
)