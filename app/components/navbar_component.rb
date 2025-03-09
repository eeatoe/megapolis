# frozen_string_literal: true

class NavbarComponent < ViewComponent::Base
  def initialize(user:, categories:)
    @user = user
    @categories = categories
  end
end
