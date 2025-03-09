class ProductRating < ApplicationRecord
  # Связи (Associations)
  belongs_to :product
  belongs_to :user

  # Валидации (Validations)
  validates :product_id, uniqueness: { scope: :user_id }
  validates :value, presence: true, 
    numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  # Коллбэки (Callbacks)
  after_save :update_product_average_rating
  after_destroy :update_product_average_rating
  after_update :update_product_average_rating

  private

  def update_product_average_rating
    product.update(average_rating: product.product_ratings.average(:value).to_f.round(2))
  end
end
