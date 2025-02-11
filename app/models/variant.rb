class Variant < ApplicationRecord
  belongs_to :product

  validates :color, :size, :weight, presence: true
  validates :color, uniqueness: { scope: [:product_id, :size], message: "Такой вариант цвета уже существует" }
  validates :size, uniqueness: { scope: [:product_id, :color], message: "Такой вариант размера уже существует" }
  validates :stock_status, presence: true, inclusion: { in: %w[in_stock out_of_stock pre_order] }
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :price, numericality: { greater_than: 0 }, allow_nil: true
  validates :weight, numericality: { greater_than: 0 }

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
