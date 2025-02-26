require 'bcrypt'

class User < ApplicationRecord
  has_secure_password

  # enum role: { customer: 0, admin: 1 }

  # Связи (associations)
  has_many :orders
  has_one :cart

  # Валидации (validations)
  validates :name, presence: true,
    length: { minimum: 2, maximum: 50 },
    format: { with: /\A[a-zA-Zа-яА-ЯёЁ\s'-]+\z/ }

  validates :email, presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: URI::MailTo::EMAIL_REGEXP },
    length: { minimum: 5, maximum: 254 }

  validates :password, presence: true,
    confirmation: true,
    format: { with: Constants::PASSWORD_FORMAT },
    length: { minimum: 6, maximum: 72 }

  validates :role, presence: true,
    inclusion: { in: %w(customer admin) }
  
    # validates :role, presence: true, inclusion: { in: roles.keys }


  # Скоупы (scopes)
  # ...
  
  # Коллбэки (callbacks)
  before_save :normalize_email
  before_save :normalize_name

  private

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end

  def normalize_name
    self.name = name.titleize if name.present?
  end
end
