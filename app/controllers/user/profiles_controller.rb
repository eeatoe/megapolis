class User::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @current_user
  end

  def update
    @user = current_user

    if @user.update(params)
      redirect_to profile_path(@user), notice: "Профиль успешно обновлен"
    else
      render :show, alert: 'Ошибка при обновлении профиля'
    end
  end

  def destroy
    @user = current_user

    if @user.destroy
      redirect_to root_path, notice: "Профиль успешно удален"
    else
      redirect_to profile_path, alert: "Не удалось удалить профиль"
    end
  end

  private

  def params
    params.require(:user).permit(:name, :email)
  end
end
