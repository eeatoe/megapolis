class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  def index
    @categories = Category.where(parent_id: nil).includes(:children)
  end

  def show
    @category = Category.find_by_slug(params[:slug])
    @subcategories = @category.children
  end
end
