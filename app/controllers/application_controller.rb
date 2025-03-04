class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :set_categories
  before_action :set_cart

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def authenticate_user!
    unless logged_in?
      redirect_to session_path, alert: "Пожалуйста, войдите в систему для доступа к этому разделу"
    end
  end

  def set_categories
    @categories = Category.where(parent_id: nil).includes(:children)
  end

  def set_cart
    if current_user
      @cart = Cart.find_or_create_by(user_id: current_user.id)
    else
      session[:cart_id] ||= SecureRandom.hex(16)
      @cart = Cart.find_or_create_by(session_id: session[:cart_id])
    end
  end
end
