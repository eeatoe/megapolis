class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :variants, through: :cart_items

  validates :session_id, :expires_at, presence: true, unless: -> { user.present? }

  before_create :set_expires_at_for_guest

  private

  def set_session_id_for_guest
    if user.nil? && session_id.blank?
      self.session_id = SecureRandom.hex(16)
    end
  end

  def set_expires_at_for_guest
    if user.nil?
      self.expires_at = 7.days.from_now
    end
  end
end
