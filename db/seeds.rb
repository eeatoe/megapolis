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
  "Gucci"
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
clothing = Category.find_or_create_by!(name: "Одежда")
accessories = Category.find_or_create_by!(name: "Аксессуары")

# Создаём подкатегории
Category.find_or_create_by!(name: "Футболки", parent: clothing)
Category.find_or_create_by!(name: "Толстовки", parent: clothing)
Category.find_or_create_by!(name: "Куртки", parent: clothing)

Category.find_or_create_by!(name: "Сумки", parent: accessories)
Category.find_or_create_by!(name: "Ремни", parent: accessories)
Category.find_or_create_by!(name: "Очки", parent: accessories)

# <--------------------------->
# Добовление тестовых Продуктов
# <--------------------------->

Product.find_or_create_by!(
  name: "Мужская спортивная куртка с утеплителем для холодной погоды",
  description: "Эта куртка обеспечит комфорт и защиту в холодные дни. Ветрозащитная ткань, удобный капюшон и стильный крой делают её идеальным выбором для активного отдыха.",
  base_price: 5990.00,
  main_material: "Полиэстер",
  filling_material: "Синтепон",
  category: Category.find_by(name: "Куртки"),
  brand: Brand.find_by(name: "Nike")
)
