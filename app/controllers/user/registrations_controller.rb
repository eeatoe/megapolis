class User::RegistrationsController < ApplicationController
  def create
    result = User::RegistrationService.call(params)

    if result.success?
      session[:user_id] = resul.user.id
      redirect_to root_path, notice: "Регистрация успешна"
    else
      flash.now[:alert] = result.errors.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
