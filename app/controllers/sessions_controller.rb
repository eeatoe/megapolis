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
      flash.now[:error] = "Пользователь с таким email не найден"
    elsif user.authenticate(password)
      session[:user_id] = user.id
      redirect_to root_path, notice: "Авторизация успешна"
    else
      flash.now[:error] = "Неверный пароль"
    end

    render :new, status: :unprocessable_entity
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Выход из системы успешен"
  end
end
