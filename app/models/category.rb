class Category < ApplicationRecord
  include SlugGeneratable
  include Constants

  # Связи (associations)
  has_many :products

  # Создание связей для подкатегорий
  belongs_to :parent, class_name: "Category", optional: true
  has_many :children, class_name: "Category", foreign_key: "parent_id", dependent: :destroy

  # Валидации (validations)
  # validates :name, presence: true, uniqueness: true,
  #   format: { with: LETTERS_ONLY_FORMAT }
  
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
end
