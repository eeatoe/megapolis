class Product < ApplicationRecord
  # Связи (associations)
  belongs_to :category
  belongs_to :brand, optional: true 
  has_many :variants, dependent: :destroy
  has_many_attached :images, dependent: :purge # Active Storage

  # Валидации (validations)
  validates :name, presence: true, 
    uniqueness: true,
    format: { with: Constants::ALPHANUMERIC_NAME_FORMAT },
    length: { minimum: 20, maximum: 100 }

  validates :description, presence: true, 
    length: { maximum: 500 }

  validates :base_price, presence: true, 
    numericality: { greater_than: 0 }

  validates :main_material, presence: true, 
    format: { with: Constants::ALPHANUMERIC_NAME_FORMAT },
    length: { maximum: 50 }
  
    validates :filling_material, 
    format: { with: Constants::ALPHANUMERIC_NAME_FORMAT },
    length: { maximum: 50 }
end
