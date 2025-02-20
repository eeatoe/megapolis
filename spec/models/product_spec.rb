require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    describe "Name" do
      # Когда имя не должно пройти валидацию
      context "when name is invalid" do
        it "is invalid without name" do
          product = build(:product, name: nil)
          expect(product).not_to be_valid
        end

        it "is invalid with a duplicate name" do
          build(:product, name: "Oleg")
          new_product = build(:product, name: "Oleg")
          expect(new_product).not_to be_valid
        end

        it "is invalid with a name shorter than 20 characters" do
          product = build(:product, name: "a" * 19)
          expect(product).not_to be_valid
        end

        it "is invalid with a name longer than 100 characters" do
          product = build(:product, name: "a" * 101)
          expect(product).not_to be_valid
        end
      end

      # Когда имя должно пройти валидацию
      context "when name is valid" do
        it "is valid without a brand" do
          product = create(:product, :with_category)
          expect(product).to be_valid
        end

        it "is valid without a category" do
          product = create(:product, :with_brand)
          expect(product).to be_valid
        end
      end
    end

    describe "Description" do
      it "is invalid without description" do
        product = build(:product, description: nil)
        expect(product).not_to be_valid
      end

      it "is invalid with a description longer than 500 characters" do
        product = build(:product, description: "a" * 501)
        expect(product).not_to be_valid
      end
    end

    describe "Base price" do
      it "is invalid without base_price" do
        product = build(:product, base_price: nil)
        expect(product).not_to be_valid
      end

      it "is invalid with negative price" do
        product = build(:product, base_price: -10)
        expect(product).not_to be_valid
      end
    end

    describe "Main material" do
      it "is invalid without main_material" do
        product = build(:product, main_material: nil)
        expect(product).not_to be_valid
      end

      it "is invalid with name of the main_material longer than 50 characters" do
        product = build(:product, main_material: "a" * 51)
        expect(product).not_to be_valid
      end
    end

    describe "Filling material" do
      it "is invalid without filling_material" do
        product = build(:product, filling_material: nil)
        expect(product).not_to be_valid
      end

      it "is invalid with name of the filling_material longer than 50 characters" do
        product = build(:product, filling_material: "a" * 51)
        expect(product).not_to be_valid
      end
    end

  end

  # Проверка ассоциаций
  describe "Associations" do
    it { should belong_to(:category) }
    it { should belong_to(:brand).optional }
    it { should have_many(:variants).dependent(:destroy) }
    it { should have_many_attached(:images) }
  end

  # Проверка зависимостей
  describe "Dependencies" do
    let(:product) { create(:product, :with_category) }

    it "is removes variants when deleting a product" do
      create(:variant, product: product)
      expect { product.destroy }.to change { Variant.count }.by(-1)
    end
  end

  # Проверка scope'ов (в будующем)
end
