# frozen_string_literal: true

class BreadcrumbsComponent < ViewComponent::Base
  def initialize(category:)
    @breadcrumb = generate_breadcrumb(category)
  end

  private

  def generate_breadcrumb(category)
    breadcrumb = []

    while category.present?
      breadcrumb.unshift(category)
      category = category.parent
    end

    breadcrumb
  end
end
