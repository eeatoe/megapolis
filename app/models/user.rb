require 'bcrypt'

class User < ApplicationRecord
  has_secure_password

  has_many :orders
  has_one :cart

  # Нормализация email перед сохранением
  normalizes :email, with: -> email { email.strip.downcase }
end
