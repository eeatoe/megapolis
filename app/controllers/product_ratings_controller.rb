class ProductRatingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @product_rating = @product.ratings.new(product_rating_params)
    @product_rating.user = current_user

    if @rating.save
      redirect_to @product, notice: I18n.t('rating_product.success.create')
    else
      redirect_to @product, alert: I18n.t('rating_product.error.create')
    end
  end

  def update
    @product_rating = current_user.ratings.find(params[:id])

    if @product_rating.update(product_rating_params)
      redirect_to @product_rating.product, notice: I18n.t('rating_product.success.update')
    else
      redirect_to @product_rating.product, alert: I18n.t('rating_product.error.update')
    end
  end

  def destroy
    @product_rating = current_user.ratings.find(params[:id])

    if @product_rating.destroy
      redirect_to @product_rating.product, notice: I18n.t('rating_product.success.destroy')
    else
      redirect_to @product_rating.product, alert: I18n.t('rating_product.error.destroy')
    end
  end

  private

  def product_rating_params
    params.require(:rating).permit(:value)
  end
end
