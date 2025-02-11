class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand, optional: true 
  has_many :variants, dependent: :destroy
  has_many_attached :images, dependent: :purge # Active Storage

  validates :name, 
    presence: true, 
    uniqueness: { message: "Уже есть товар с таким названием" },
    format: { with: /\A[1-9a-zA-Zа-яА-ЯёЁ\s'-:;]+\z/, message: "Название должно состоять из букв, цифр и символов (- : ;)" },
    length: {
      minimum: 20, too_short: "Длина названия не должна быть меньше %{count} символов",
      maximum: 100, too_long: "Длина названия не должна быть больше %{count} символов"
    }

  validates :description, 
    presence: true, 
    length: { maximum: 500, message: "Максимальная длина 500 символов" }

  validates :base_price, 
    presence: true, 
    numericality: { greater_than: 0, message: "Цена должна быть положительной" }

  validates :main_material, 
    presence: true, 
    length: { maximum: 50, message: "Максимальная длина 100 символов" }
  
    validates :filling_material, 
    length: { maximum: 50, message: "Максимальная длина 100 символов" }
end
