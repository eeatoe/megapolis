module SlugGeneratable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_slug, on: :create
  end

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
