class DeleteExpiredCartsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    expired_carts = Cart.where("expires_at < ?", Time.current)
    
    expired_carts.destroy_all
  end
end
