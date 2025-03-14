class Variant < ApplicationRecord
  # Связи (associations)
  belongs_to :product
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :card_items

  # Валидации (validations)
  validates :color, presence: true,
    uniqueness: { scope: [:product_id, :size] }
  
  validates :size, presence: true,
    uniqueness: { scope: [:product_id, :color] },
    inclusion: { in: %w[S M L XL XXL] }

  validates :stock_status, presence: true,
    inclusion: { in: %w[in_stock out_of_stock pre_order] }

  validates :stock_quantity, 
    numericality: { greater_than_or_equal_to: 0 }

  validates :price, allow_nil: true,
    numericality: { greater_than: 0 }

  validates :weight, presence: true, 
    numericality: { greater_than: 0 }

  # Скоупы (scopes)
  # ...
  
  # Коллбэки (callbacks)
  before_save :set_stock_status

  # Использовать в контроллере, чтобы указать цену  на конкретный вариант товара.
  # Если в таблице variants есть цена, то она переопределит цену из products.
  def final_price
    price.present? ? price : product.base_price
  end

  private

  def set_stock_status
    return if stock_status == "pre_order"
    self.stock_status = stock_quantity.zero? ? "out_of_stock" : "in_stock"
  end

end
