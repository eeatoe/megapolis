class ProductsController < ApplicationController
  def index
    @products = Product.all.includes(:images_attachments)
  end

  def show
    @product = Product.find_by!(slug: params[:slug])
  end
end
