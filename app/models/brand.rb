class Brand < ApplicationRecord
  include SlugGenerator

  # Связи (associations)
  has_many :products, dependent: :nullify
  has_one_attached :logo, dependent: :purge # Active Storage

  # Валидации (validations)
  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: { case_sensitive: false }

  private

  def set_image_path
    self.image.each do |image|
      image_path = "products/#{category.slug}/#{id}/#{image.filename}"
      image.filename = image_path
    end
  end
end
