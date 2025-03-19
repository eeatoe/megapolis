class Product < ApplicationRecord
  include SlugGeneratable

  # Связи (associations)
  belongs_to :category
  belongs_to :brand, optional: true 
  has_many :variants, dependent: :destroy
  has_many :product_ratings, dependent: :destroy
  has_many_attached :images, dependent: :purge # Active Storage

  # Валидации (validations)
  validates :name, presence: true, 
    uniqueness: true,
    format: { with: Constants::ALPHANUMERIC_NAME_FORMAT },
    length: { minimum: 10, maximum: 90 }

  validates :slug, presence: true, uniqueness: { case_sensitive: false }

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

  # Коллбэки (callbacks)
  # before_save :set_image_path

  # Скоупы (scopes)
  # scopes :with_max_sales, { where(sales_count: maximum(:sales_count)) }

  def average_rating
    self[:average_rating]
  end

  def to_param; slug; end

  private

  def set_image_path
    self.image.each do |image|
      image_path = "products/#{category.slug}/#{id}/#{image.filename}"
      image.filename = image_path
    end
  end
end
