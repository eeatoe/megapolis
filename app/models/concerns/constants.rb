module Constants
  PASSWORD_FORMAT = /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*\z/

  LETTERS_ONLY_FORMAT = /\A[a-zA-Zа-яА-ЯёЁ]+\z/
  ALPHANUMERIC_NAME_FORMAT = /\A[a-zA-Zа-яА-ЯёЁ][a-zA-Zа-яА-ЯёЁ\d\s'’\-:;%]*[a-zA-Zа-яА-ЯёЁ\d]\z/
end