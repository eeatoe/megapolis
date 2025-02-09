class Category < ApplicationRecord
  has_many :products, dependent: :nullify

  # Создание связей для подкатегорий
  belongs_to :parent, class_name: "Category", optional: true
  has_many :children, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
end
