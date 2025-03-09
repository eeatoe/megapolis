# frozen_string_literal: true

class RatingStarsComponent < ViewComponent::Base
  def initialize(average_rating:)
    @average_rating = average_rating
  end
end
