require 'rails_helper'

RSpec.describe Constants do
  describe "LETTERS_ONLY_FORMAT" do
    let(:valid_names) do
      [
        "Hellow Wold",
        "ПриветМир"
      ]
    end

    let(:invalid_names) do
      [
        "Hello123",
        "Hellow!",
        ""
      ]
    end

    it "are valid names" do
      valid_names.each do |name|
        expect(name).to match(Conctant::LETTERS_ONLY_FORMAT)
      end
    end

    it "are invalid names" do
      invalid_names.each do |name|
        expect(name).not_to match(Conctant::LETTERS_ONLY_FORMAT)
      end
    end
  end

  describe "ALPHANUMERIC_NAME_FORMAT" do
    let(:valid_names) do
      [
        "Hello Wold",
        "ПриветМир",
        "Привет 123",
        "Hello '’\-:;% World"
      ]
    end

    let(:invalid_names) do
      [
        "Hello123",
        "Hello!",
        "Привет ",
        " Привет",
        "Hello'",
        ""
      ]
    end

    it "are valid names" do
      valid_names.each do |name|
        expect(name).to match(Conctant::ALPHANUMERIC_NAME_FORMAT)
      end
    end

    it "are invalid names" do
      invalid_names.each do |name|
        expect(name).not_to match(Conctant::ALPHANUMERIC_NAME_FORMAT)
      end
    end
  end
end
