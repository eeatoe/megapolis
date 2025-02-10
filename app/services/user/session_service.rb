class User::SessionService
  def initialize(params)
    @params = params
  end

  def call
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      ServiceResult.success(user)
    else
      ServiceResult.failure(user.errors.full_messages)
    end
  end
end