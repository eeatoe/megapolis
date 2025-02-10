class ServiceResult
  attr_reader :success, :data, :error

  def initialize(success:, data: nil, error: [])
    @success = success
    @data = data
    @error = Array(error)
  end

  def success?
    success
  end

  def failure?
    !success
  end

  def self.success(data = nil)
    new(success: true, data: data)
  end

  def self.failure(errors)
    new(success: false, errors: errors)
  end
end