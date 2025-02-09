class Brand < ApplicationRecord
  has_many :products, dependent: :nullify
  has_one_attached :logo, dependent: :purge # Active Storage

  validates :name, presence: true, uniqueness: true
end
