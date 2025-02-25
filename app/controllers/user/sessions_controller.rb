class User::SessionsController < ApplicationController

  def new
  end

  def create
    result = User::SessionService.call(params)

    if result.success?
      session[:user_id] = result.user.id
      redirect_to root_path, notice: "Авторизация успешна"
    else
      flash.now[:alert] = result.errors.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Выход из системы успешен"
  end
end
