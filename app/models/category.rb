class Category < ApplicationRecord
  include Constants
  # include SlugGeneratable

  # Связи (associations)
  has_many :products, dependent: :nullify

  # Создание связей для подкатегорий
  belongs_to :parent, class_name: "Category", optional: true
  has_many :children, class_name: "Category", foreign_key: "parent_id", dependent: :destroy

  # Валидации (validations)
  # validates :name, presence: true, uniqueness: true,
  #   format: { with: LETTERS_ONLY_FORMAT }
  
  # validates :slug, presence: true, uniqueness: { case_sensitive: false }

  before_validation :generate_slug

  private

  def transliterate(text)
    mapping = {
      "а" => "a", "б" => "b", "в" => "v", "г" => "g", "д" => "d", "е" => "e", "ё" => "yo", "ж" => "zh", "з" => "z",
      "и" => "i", "й" => "y", "к" => "k", "л" => "l", "м" => "m", "н" => "n", "о" => "o", "п" => "p", "р" => "r",
      "с" => "s", "т" => "t", "у" => "u", "ф" => "f", "х" => "kh", "ц" => "ts", "ч" => "ch", "ш" => "sh", "щ" => "sch",
      "ы" => "y", "э" => "e", "ю" => "yu", "я" => "ya"
    }
    text.chars.map { |char| mapping[char] || char }.join
  end

  def generate_slug
    self.slug ||= transliterate(name.downcase).parameterize if name.present? && slug.blank?
  end
end
