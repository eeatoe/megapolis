class UsersController < ApplicationController
  def new
    redirect_to root_path if logged_in?
    @user = User.new # Отображаем форму
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: I18n.t("signup.success.create")
    else
      flash.now[:error] = @user.errors.full_messages.join(". ")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end