class User::RegistrationService
  def initialize(params)
    @params = params
  end

  def call
    user = User.new(@params)

    if user.save
      ServiceResult.success(user)
    else
      ServiceResult.failure(user.errors.full_messages)
    end
  end
end