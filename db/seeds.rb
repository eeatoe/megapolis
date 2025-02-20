# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Создание основных категорий товаров
outerwear = Category.create(name: "Верхняя одежда")
jackets = Category.create!(name: "Куртки", parent: outerwear)
tops = Category.create!(name: "Легкая верхняя одежда")
trousers = Category.create!(name: "Брюки")

# Создание подкатегорий для Верхний одежды
Category.create!(name: "Ветровки", parent: outerwear)
Category.create!(name: "Жилеты", parent: outerwear)
Category.create!(name: "Анораки", parent: outerwear)
Category.create!(name: "Флисовые куртки", parent: outerwear)

# Подкатегории для курток
Category.create!(name: "Демисезонные куртки", parent: jackets)
Category.create!(name: "Зимние куртки", parent: jackets)
Category.create!(name: "Пуховики", parent: jackets)
Category.create!(name: "Бомберы", parent: jackets)


# Подкатегории для топов
Category.create!(name: "Футболки", parent: tops)
Category.create!(name: "Рубашки", parent: tops)
Category.create!(name: "Кофты", parent: tops)
Category.create!(name: "Поло", parent: tops)

# Подкатегории для брюк
Category.create!(name: "Спортивные штаны", parent: trousers)
Category.create!(name: "Джинсы", parent: trousers)
Category.create!(name: "джоггеры", parent: trousers)
Category.create!(name: "чиносы", parent: trousers)
Category.create!(name: "Шорты", parent: trousers)

