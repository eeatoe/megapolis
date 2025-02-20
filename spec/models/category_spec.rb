require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Associations" do
    it { should have_many(:products).dependent(:nullify) }
    it { should belong_to(:parent).class_name("Category").optional }
    it { should have_many(:children).class_name("Category").with_foreign_key("parent_id").dependent(:destroy) }
  end

  describe "Validation" do
    describe "Name" do
      it "is invalid without name" do
        category = build(:category, name: nil)
        expect(category).not_to be_valid
      end

      it "is invaild with a dublicate name" do
        build(:category, name: "Jeans")
        category = build(:category, name: "Jeans")
        expect(category).not_to be_valid
      end

      it "is invalid without slug" do
        category = build(:category, slug: nil)
        expect(category).not_to be_valid
      end

      it "is invaild with a dublicate slug" do
        build(:category, slug: "jeans")
        category = build(:category, slug: "jeans")
        expect(category).not_to be_valid
      end
    end
  end

  describe "Callbacks" do
    it "generates slug before validation, if it is empty" do
      category = build(:category, name: "Тестовая категория", slug: nil)
      category.valid?
      expect(category.slug).to eq("тестовая-категория")
    end
  end

  describe "Dependencies" do
    let!(:parent_category) { create(:category) }
    let!(:child_category) { create(:category, parent: parent_category) }
    let!(:product) { create(:product, category: parent_category) }

    it "deletes child categories when parents is deleted" do
      expect { parent_category.destroy }.to change { Category.count }.by(-1)
    end

    it "does't delete related products, but only resets their category" do
      expect { parent_category.destroy }.to change { product.reload.category_id }.to(nil)
    end
  end
end
