require 'bcrypt'

class User < ApplicationRecord
  has_secure_password

  has_many :orders
  has_one :cart

  # Нормализация email перед сохранением
  normalizes :email, with: -> email { email.strip.downcase }

  validates :email, 
    presence: { message: "Поле email должно быть заполненным" },
    uniqueness: { message: "Пользователь с таким email уже есть" }

end
