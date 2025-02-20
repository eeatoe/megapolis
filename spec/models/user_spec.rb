require 'rails_helper'

RSpec.describe User, type: :model do
  # Проверка валидаций
  describe "Validations" do
    
    # Валидация имени пользователя
    describe "Name" do
      # Когда имя не должно пройти валидацию
      context "when name is invalid" do
        it "is not valid without a name" do
          user = build(:user, name: nil)
          expect(user).not_to be_valid
        end
  
        it "is invalid with a name longer than 50 characters" do
          user = build(:user, name: "e" * 51)
          expect(user).not_to be_valid
        end
  
        it "is invalid with a name shorter than 2 characters" do
          user = build(:user, name: "e")
          expect(user).not_to be_valid
        end

        # Валидация формата имени пользователя
        context "when name has incorrect format" do
          it "is invalid with numbers" do
            user = build(:user, name: "123456789")
            expect(user).not_to be_valid
          end

          it "is invalid with special characters" do
            user = build(:user, name: "Anna&#$%")
            expect(user).not_to be_valid
          end
        end
      end

      # Когда имя должно пройти валидацию
      context "when name is valid" do
        it "is valid with cyrillic letters" do
          user = build(:user, name: "Кирил")
          expect(user).to be_valid
        end

        it "is valid with latin letters" do
          user = build(:user, name: "Anna")
          expect(user).to be_valid
        end

        it "is valid with permissible characters (' and -)" do
          user = build(:user, name: "D'Artagnan-Luc")
          expect(user).to be_valid
        end
      end
    end

  
    # Валидация электронной почты
    describe "Email" do
      context "when email is invalid" do
        it "is not valid without a email" do
          user = build(:user, email: nil)
          expect(user).not_to be_valid
        end

        it "is invalid with a duplicate email" do
          build(:user, email: "test@example.com")
          new_user = build(:user, email: "test@example.com")
          expect(new_user).not_to be_valid
        end

        it "is invalid with an email longer than 254 characters" do
          user = build(:user, email: "a" * 255 + "@example.com")
          expect(user).not_to be_valid
        end

        it "is invalid with an email shorter than 5 characters" do
          user = build(:user, email: "a@b.c")
          expect(user).not_to be_valid
        end

        # Валидация формата электронной почты
        context "when email has incorrect format" do
          it "is invalid without '@' symbol" do
            user = build(:user, email: "invalidemail.com")
            expect(user).not_to be_valid
          end

          it "is invalid without domain" do
            user = build(:user, email: "test@")
            expect(user).not_to be_valid
          end

          it "is invalid with a missing local part before @" do
            user = build(:user, email: "@domain.com")
            expect(user).not_to be_valid
          end

          it "is invalid with spaces" do
            user = build(:user, email: "test @example.com")
            expect(user).not_to be_valid
          end

          it "is invalid with special characters" do
            user = build(:user, email: "test!#$%@example.com")
            expect(user).not_to be_valid
          end
        end
      end
    end


    # Валидация пароля
    describe "Password" do
      # Когда пароль не должен пройти валидацию
      context "when email is invalid" do
        it "is invalid when password and confirmation do not match" do
          user = build(:user, password: "Ab123456", password_confirmation: "Ba654321")
          expect(user).not_to be_valid
        end

        it "is not valid without a password" do
          user = build(:user, password: nil)
          expect(user).not_to be_valid
        end

        it "is not valid without a password confirmation" do
          user = build(:user, password_confirmation: nil)
          expect(user).not_to be_valid
        end

        it "is invalid if password is too short" do
          user = build(:user, password: "Aa1", password_confirmation: "Aa1")
          expect(user).not_to be_valid
        end

        it "is invalid if password is too long" do
          long_password = "A" * 73
          user = build(:user, password: long_password, password_confirmation: long_password)
          expect(user).not_to be_valid
        end

        # Валидация формата пароля
        context "when password has incorrect format" do
          it "is invalid without a digit" do
            password = "HelloWorld"
            user = build(:user, password: password, password_confirmation: password)
            expect(user).not_to be_valid
          end

          it "is invalid without an uppercase letter" do
            password = "helloworld123"
            user = build(:user, password: password, password_confirmation: password)
            expect(user).not_to be_valid
          end

          it "is invalid without a lowercase letter" do
            password = "HELLOWORLD123"
            user = build(:user, password: password, password_confirmation: password)
            expect(user).not_to be_valid
          end
        end 
      end
    end

    # Валидация роли
    describe "Role" do
      # Когда роль должна пройти валидацию
      context "when role is valid" do
        it "allows 'customer' as a role" do
          user = build(:user, role: "customer")
          expect(user).to be_valid
        end

        it "allows 'admin' as a role" do
          user = build(:user, role: "admin")
          expect(user).to be_valid
        end
      end

      # Когда роль не должна пройти валидацию
      context "when role is invalid" do
        it "is invalid without a role" do
          user = build(:user, role: nil)
          expect(user).not_to be_valid
          expect(user.errors[:role]).to include("can't be blank")
        end

        it "is invalid with an unknown role" do
          user = build(:user, role: "moderator")
          expect(user).not_to be_valid
          expect(user.errors[:role]).to include("is not included in the list")
        end
      end
    end
  end

  # Проверка коллбеков
  describe "Callbacks" do
    let(:user) { build(:user, email: " TeST@Example.com ", name: "жан поль") }
    
    it "normalizes email before saving" do
      user.save
      expect(user.email).to eq("test@example.com")
    end

    it "capitalizes name before saving" do
      user.save
      expect(user.name).to eq("Иван Иванов")
    end
  end

  # Проверка ассоциаций
  describe "Associations" do
    it { should have_many(:orders) }
    it { should have_one(:cart) }
  end

  # Проверка шифрования пароля
  describe "Password encryption" do
    # Проверяем, что password_digest создается
    describe "Password encryption" do
      let(:user) { create(:user, password: "Password123", password_confirmation: "SecurePass123") }
  
      it "encrypts the password" do
        expect(user.password_digest).to be_present
        expect(user.password_digest).not_to eq("Password123")
      end
    end

    # Проверка, что метод authenticate работает правильно
    describe "Password authentication" do
      let(:user) { create(:user, password: "Password123", password_confirmation: "SecurePass123") }
  
      it "authenticates with correct password" do
        expect(user.authenticate("Password123")).to eq(user)
      end
  
      it "fails authentication with incorrect password" do
        expect(user.authenticate("WrongPassword")).to be_falsey
      end
    end

    # Проверяем, что неля записать пароль напрямую в password_digest
    describe "Security" do
      it "does not allow direct assignment of password_digest" do
        user = build(:user)
        expect { user.password_digest = "fakehash" }.to raise_error(ActiveModel::MassAssignmentSecurity::Error).or change { user.password_digest }.by(nil)
      end
    end
  end

  # Проверка фабрики FactoryBot
  describe "FactoryBot" do
    it "creates a valid user"
    it "creates multiple users with unique emails"
    it "creates an admin user using trait"
  end
end
