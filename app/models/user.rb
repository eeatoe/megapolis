require 'bcrypt'

class User < ApplicationRecord
  has_secure_password

  has_many :orders
  has_one :cart

  # Нормализация email и name перед сохранением в БД
  before_save :normalize_email
  before_save :normalize_name

  # Регулярное выражение для валидации пароля
  PASSWORD_FORMAT = /\A
    (?=.*\d)           # Должен содержать цифры
    (?=.*[a-z])        # Должен содержать строчные буквы
    (?=.*[A-Z])        # Должен содержать заглавные буквы
  \z/x

  validates :name,
    presence: { message: "Поле с именем должно быть заполненным"},
    length: { 
      minimum: 2, too_short: "Имя должно быть больше %{count} символов",
      maximum: 50, too_long: "Имя должно быть меньше %{count} символов"
    },
    format: { with: /\A[a-zA-Zа-яА-ЯёЁ\s'-]+\z/, message: "Имя должно состаять только из букв" }

  validates :email, 
    presence: { case_sensitive: false, message: "Поле email должно быть заполненным" },
    uniqueness: { message: "Пользователь с таким email уже есть" },
    format: { with: URI::MailTo::EMAIL_REGEXP, message: "Неправильный формат email" },
    length: {
      maximum: 254, minimum: 5, 
      message: "Электронных почт такой длины не существует"
    }

  validates :password,
    confirmation: { message: "Пароли не совпадают" },
    presence: { message: "Поле пароля должно быть заполненным" },
    format: { with: PASSWORD_FORMAT, message: "Пароль должен содержать хотя бы одну цифру, одну заглавную и одну строчную букву" },
    length: { 
      minimum: 6, too_short: "Длина пароля не должна быть меньше %{count} символов",
      maximum: 72, too_long: "Длина пароля не должна быть больше %{count} символов"
    }

  validates :password_confirmation, 
    presence: { message: "Поле подтверждения пароля должно быть заполненным" }, if: -> { password.present? }

  validates :role,
    presence: true,
    inclusion: { in: %w(customer admin) }


  private

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end

  def normalize_name
    self.name = name.titleize if name.present?
  end
end
