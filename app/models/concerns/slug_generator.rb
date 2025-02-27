module SlugGenerator
  extend ActiveSupport::Concern

  include do
    before_validation :generate_slug, on: :create
  end

  private

  def generate_slug
    self.slug ||= name.parameterize if name.present? && slug.blank?
  end
end