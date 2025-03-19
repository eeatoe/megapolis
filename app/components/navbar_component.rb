# frozen_string_literal: true

class NavbarComponent < ViewComponent::Base
  def initialize(user:, categories:, is_landing: false)
    @user = user
    @categories = categories
    @is_landing = is_landing
  end
end
