class CardsController < ApplicationController
  before_action :find_or_create_cart

  def update_cart
    
  end

  private

  def find_or_create_cart
    if current_user
      @cart = current_user.cart || current_user.create_cart
    else
      @cart = Cart.find_by(session_id: session[:cart_id])

      if @cart.nil?
        @cart = Cart.create(session_id: session[:cart_id] || SecureRandom.hex(16))
        session[:cart_id] = @cart.session_id
      end
    end
  end
end
