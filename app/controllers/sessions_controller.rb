class SessionsController < ApplicationController
  def new
    redirect_to root_path if logged_in? # Если пользователь уже авторизован, перенаправляем его
    @user = User.new # Создаем временный объект для формы
  end


  def create
    email = params[:user][:email].downcase
    password = params[:user][:password]

    user = User.find_by(email: email)

    if user.nil?
      flash.now[:error] = I18n.t("login.error.create.missing")
    elsif user&.authenticate(password)
      session[:user_id] = user.id
      merge_carts(user) # Объединяем корзины

      redirect_to root_path, notice: I18n.t("login.success.create")
    else
      flash.now[:error] = I18n.t("login.error.create.wrong_password")
    end

    render :new, status: :unprocessable_entity
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: I18n.t("login.success.destroy")
  end

  private

  def merge_carts(user)
    guest_cart = Cart.find_by(session_id: session[:cart_id])
    user_cart = Cart.find_or_create_by(user_id: user.id)

    return unless guest_cart

    guest_cart.items.each do |item|
      existing_item = user_cart.items.find_by(product_id: item.product_id)

      if existing_item
        existing_item.update(quantity: existing_item.quantity + item.quantity)
      else
        item.update(cart_id: user_cart.id)
      end
    end

    guest_cart.destroy
    session[:cart_id] = nil
  end
end
