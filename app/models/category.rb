class Category < ApplicationRecord
  include SlugGenerator

  # Связи (associations)
  has_many :products, dependent: :nullify

  # Создание связей для подкатегорий
  belongs_to :parent, class_name: "Category", optional: true
  has_many :children, class_name: "Category", foreign_key: "parent_id", dependent: :destroy

  # Валидации (validations)
  validates :name, presence: true, uniqueness: true,
    format: { with: /\A[a-zA-Zа-яА-ЯёЁ\s'-]+\z/, message: "Название категории должно состаять только из букв" }
  
  validates :slug, presence: true, uniqueness: { case_sensitive: false }

  # Коллбэки (callbacks)
  before_validation :generate_slug, on: :create
end
